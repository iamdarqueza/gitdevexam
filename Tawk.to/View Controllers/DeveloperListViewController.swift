//
//  DeveloperListViewController.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import UIKit
import Combine
import Connectivity
import Loaf

class DeveloperListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let connectivity = Connectivity()
    private var cancellable: AnyCancellable?
    private var fromOffline = false
    private var isOffline = false
    private var viewModel = DeveloperListViewModel(task: DeveloperListService())
    private var queue = OperationQueue()
    private var isSearching = false
    private var developerIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        configureConnectivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureConnectivityNotifier()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showProfile.rawValue {
              let destination = segue.destination as! DeveloperProfileViewController
            guard let index = developerIndex else { return }
            destination.bindVM(username: viewModel.developerList[index].login ?? .empty)
        }
    }
    
    
    // MARK: - Configure table view
    private func configureTableView() {
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(cell: DevTableViewCell.self)
      tableView.tableFooterView = UIView()
      tableView.rowHeight = 100
    }
    
    
    // MARK: - Configure search button
    private func configureSearchBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.placeholder = "Search developer.."
        searchBar.delegate = self
    }
    
    
    // MARK: - Configure internet connection checker
    private func configureConnectivity() {
        connectivity.checkConnectivity { [weak self] connectivity in
          guard let s = self else { return }

          switch connectivity.status {
          case .connected, .connectedViaWiFi, .connectedViaCellular:
            s.getDeveloperList()
          case .connectedViaWiFiWithoutInternet, .notConnected, .connectedViaCellularWithoutInternet:
            Loaf("You have no internet connection", state: .error, location: .top, sender: s).show()
            s.getOfflineList()
          case .determining:
            break
          }
        }
    }
    
    // MARK: - Configure internet connection notifier
    private func configureConnectivityNotifier() {
      let publisher = Connectivity.Publisher()
      cancellable = publisher.receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] connectivity in
          guard let s = self else {
            return
          }
          s.updateConnectionStatus(connectivity.status)
        })
    }
    
    // MARK: - Check connection and display online or offline
    private func updateConnectionStatus(_ status: Connectivity.Status) {
      switch status {
      case .connectedViaWiFi, .connectedViaCellular, .connected:
        isOffline = false
        if fromOffline {
            fromOffline = false
            Loaf("You have an active internet connection", state: .success, location: .top, sender: self).show()
          if CoreDataManager.shared.getUsers().count == 0 {
            getDeveloperList()
          }
        }
      case .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .notConnected:
        isOffline = true
        fromOffline = true
        Loaf("You have no internet connection", state: .error, location: .top, sender: self).show()
      case .determining:
        break
      }
    }
    
    // MARK: - Get developer list
    private func getDeveloperList() {
      viewModel.requestDevList(
        onSuccess: onHandleSuccess(),
        onError: onHandleError()
      )
    }

    
    // MARK: - Get developer list in Core Data when offline
    private func getOfflineList() {
      viewModel.getOfflineUser()
      tableView.reloadData()
    }
    
    
    // MARK: - Success Get developer list
    private func onHandleSuccess() -> SingleResult<Bool> {
      return { [weak self] status in
        guard let s = self, status else { return }
        DispatchQueue.main.async {
          s.tableView.reloadData()
        }
      }
    }

    // MARK: - Display error encountered after fetch
    private func onHandleError() -> SingleResult<String> {
      return { [weak self] message in
        guard let s = self else { return }
          s.presentDismissableAlertController(title: "Oops!", message: message)
      }
    }


    
    

}

extension DeveloperListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.developerList.count == 0 ? 10 : viewModel.developerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.devTableViewCell.rawValue, for: indexPath) as! DevTableViewCell
        
                if viewModel.developerList.count != 0 {
                  let devs = viewModel.developerList[indexPath.row]
                    cell.configure(withDev: devs, index: indexPath.row)
                }
        if viewModel.developerList.count != 0 {
          cell.hideSkeletonView()
          let devs = viewModel.developerList[indexPath.row]
            cell.configure(withDev: devs, index: indexPath.row)
        } else {
          cell.showAnimatedGradientSkeleton()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        developerIndex = indexPath.row
        performSegue(withIdentifier: SegueIdentifiers.showProfile.rawValue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      cell.selectionStyle = .none

      let lastItem = viewModel.developerList.count - 1
      if indexPath.row == lastItem {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)
        tableView.tableFooterView = spinner

        if !isSearching && !isOffline {
          getDeveloperList()
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            tableView.tableFooterView = nil
          }
        } else {
          tableView.tableFooterView = nil
        }
      }
    }

}


extension DeveloperListViewController: UISearchBarDelegate {

    // MARK: - Update search result
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
          isSearching = true
          viewModel.searchProcess(text: text)
        } else {
          isSearching = false
          viewModel.setOriginalList()
        }
        tableView.reloadData()
    }
    

}
