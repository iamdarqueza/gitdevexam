//
//  DeveloperProfileViewController.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import UIKit
import Combine

class DeveloperProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var noteTextView: DesignableTextView!
    @IBOutlet weak var saveNoteButton: DesignableButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var noteView: UIView!

    @IBOutlet weak var screenView: UIView!
    @IBOutlet var screenParentView: UIView!
    
    
    var developer: Devs?
    private var viewModel = DeveloperProfileViewModel(task: DeveloperProfileService())
    private var imageRequester: AnyCancellable?
    

    @IBAction func didTapSaveButton(_ sender: Any) {
        view.endEditing(true)
        guard !noteTextView.text.isEmpty, noteTextView.text != "Type your note here.." else {
            self.presentDismissableAlertController(title: "Oops!", message: "Your note is empty")
          return
        }
        
        if let developerInfo = viewModel.developerInfo {
          CoreDataManager.shared.saveNotes(dev: developerInfo, notes: noteTextView.text, onSuccess: onSaveSuccess())
        }
    }
    
    func bindVM(username: String) {
      viewModel.userName = username
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "\(developer?.login ?? "")"
        getDevDetails()
        configureNote()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        configureBackgroundView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageRequester?.cancel()
    }
    
    private func configureNote() {
        self.saveNoteButton.isEnabled = false
        noteTextView.delegate = self
    }
    
    
    // MARK: - Get developer details
    private func getDevDetails() {
      showSkeletonView()
      viewModel.requestDevInfo(onSuccess: onHandleSuccess(), onError: onHandleError())
    }
    
    // MARK: - Success get developer details
    private func onHandleSuccess() -> SingleResult<Bool> {
      return { [weak self] status in
        guard let s = self, status else { return }
        DispatchQueue.main.async {
          s.populateDetails()
        }
      }
    }

    // MARK: - Success save note
    private func onSaveSuccess() -> SingleResult<Bool> {
      return { [weak self] status in
        guard let s = self, status else { return }
        DispatchQueue.main.async {
          s.presentDismissableAlertController(title: "Success!", message: "You have successfully saved a note")
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
    
    
    // MARK: - Show skeleton loading
    private func showSkeletonView() {
        followersLabel.showAnimatedGradientSkeleton()
        followingLabel.showAnimatedGradientSkeleton()
        nameLabel.showAnimatedGradientSkeleton()
        companyLabel.showAnimatedGradientSkeleton()
        blogLabel.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Hide skeleton loading
    private func hideSkeletonView() {
        followersLabel.hideSkeleton()
        followingLabel.hideSkeleton()
        nameLabel.hideSkeleton()
        companyLabel.hideSkeleton()
        blogLabel.hideSkeleton()
    }
    
    
    // MARK: - Configure background view to suppport dark mode
    private func configureBackgroundView() {
        if (self.traitCollection.userInterfaceStyle == .dark) {
            screenView.backgroundColor = UIColor.colorWithRGBHex(0x07070E)
            screenParentView.backgroundColor = UIColor.colorWithRGBHex(0x07070E)
            noteTextView.backgroundColor = UIColor.colorWithRGBHex(0x666666)
            noteTextView.textColor = UIColor.white
         } else {
            screenView.backgroundColor = UIColor.colorWithRGBHex(0xF9F9F9)
            screenParentView.backgroundColor = UIColor.colorWithRGBHex(0xF9F9F9)
            noteTextView.backgroundColor = UIColor.colorWithRGBHex(0xE3E3E3)
            noteTextView.textColor = UIColor.black
         }
    }
    
    
    // MARK: - Populate data
    private func populateDetails() {
      hideSkeletonView()
      title = viewModel.developerInfo?.name ?? ""
      followersLabel.text = "\(viewModel.developerInfo?.followers ?? 0)"
      followingLabel.text = "\(viewModel.developerInfo?.following ?? 0)"
      nameLabel.text = "\(viewModel.developerInfo?.name ?? " ")"
      blogLabel.text = "\(viewModel.developerInfo?.blog ?? " ")"
        
      if let url = URL(string: viewModel.developerInfo?.avatarURL ?? .empty) {
        imageRequester = ImageLoader.shared.loadImage(from: url).sink { [weak self] image in
            self?.profileImageView.image = image
        }
      }
        
      if (viewModel.developerInfo?.company == "" || viewModel.developerInfo?.company == " ") {
            companyLabel.text = "N/A"
      } else {
            companyLabel.text = "\(viewModel.developerInfo?.company ?? "N/A")"
      }
          
      if (CoreDataManager.shared.getNotesById(id: viewModel.developerInfo?.id ?? -1) == "") {
            noteTextView.text = "Type your note here.."
            noteTextView.textColor = UIColor.lightGray
      } else {
            noteTextView.text = CoreDataManager.shared.getNotesById(id: viewModel.developerInfo?.id ?? -1)
      }
        
      saveNoteButton.isEnabled = true
    }
    

}


extension DeveloperProfileViewController: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteTextView.textColor == UIColor.lightGray {
            noteTextView.text = nil
            noteTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextView.text.isEmpty {
            noteTextView.text = "Type your note here.."
            noteTextView.textColor = UIColor.lightGray
        }
    }
    
}
