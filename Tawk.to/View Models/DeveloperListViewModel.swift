//
//  DeveloperListViewModel.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

// MARK: - Protocol for DevListViewModel

protocol DeveloperListViewModelProtocol {
  var lastDevId: Int { get set }
  var sinceId: Int { get set }

  var developerList: DeveloperListResponse { get set }
  func requestDevList(
    onSuccess: @escaping SingleResult<Bool>,
    onError: @escaping SingleResult<String>
  )
}

final class DeveloperListViewModel: DeveloperListViewModelProtocol {
  private var service: DeveloperListServiceProtocol
  var developerList: DeveloperListResponse = []
  var originalList: DeveloperListResponse = []
  var lastDevId: Int = 0
  var sinceId: Int = 0

  private var queue = OperationQueue()

  init(task: DeveloperListServiceProtocol) {
    service = task
    queue.maxConcurrentOperationCount = 1
  }

  // MARK: - request for Dev List
  func requestDevList(onSuccess: @escaping SingleResult<Bool>, onError: @escaping SingleResult<String>) {
    
    queue.cancelAllOperations()
    queue.qualityOfService = .background

    let user = CoreDataManager.shared.getLastIndexId()
    lastDevId = Int(user?.id ?? 0)

    let block = BlockOperation { [weak self] in
      guard let s = self else { return }
      s.service.getDeveloperList(
        id: s.sinceId, onHandleCompletion: { [weak self] result, status, message in
          guard let s = self else { return }
          if let list = result, status {
            if s.sinceId == 0 {
              CoreDataManager.shared.clearAllDevs()
              s.developerList.removeAll()
            }
            s.developerList.append(contentsOf: list)
            s.originalList = s.developerList
            if let lastDev = list.last {
              let since = Int(lastDev.id)
                print(since)
            }
            s.saveToCoreData()
            onSuccess(status)
          } else {
            onError(message ?? .empty)
          }
        }
      )
    }
    
    queue.addOperation(block)
  }

  // MARK: - Save to core data
  func saveToCoreData() {
    CoreDataManager.shared.saveContext()
    sinceId = Int(developerList[developerList.count - 1].id)
  }

  // MARK: - Search processing
  func searchProcess(text: String) {
    if !text.isEmpty {
        developerList = originalList.filter({ (devs) -> Bool in
        let username = devs.login?.lowercased().contains(text.lowercased())
        let notes = devs.notes?.lowercased().contains(text.lowercased())
        return (username == true || notes == true)
      })
    } else {
        developerList = originalList
    }
  }
  
  // MARK: - After clear search set it back to original list
  func setOriginalList() {
    developerList = originalList
  }
  
  // MARK: - Fetch users of no connection
  func getOfflineUser() {
    developerList = CoreDataManager.shared.getUsers()
    originalList = CoreDataManager.shared.getUsers()

  }
}
