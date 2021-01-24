//
//  DeveloperProfileViewModel.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

protocol DeveloperProfileViewModelProtocol {
  var userName: String { get set }
  var developerInfo: DeveloperProfileResponse?  { get set }
  func requestDevInfo(onSuccess: @escaping SingleResult<Bool>, onError: @escaping SingleResult<String>)
}

final class DeveloperProfileViewModel: DeveloperProfileViewModelProtocol {
  var userName: String = .empty
  var developerInfo: DeveloperProfileResponse?

  private var service: DeveloperProfileServiceProtocol

  init(task: DeveloperProfileServiceProtocol) {
    service = task
  }

  func requestDevInfo(onSuccess: @escaping SingleResult<Bool>, onError: @escaping SingleResult<String>) {
    service.getDeveloperProfile(username: userName) { [weak self] result, status, message in
      guard let s = self else { return }
      if status {
        s.developerInfo = result
        onSuccess(status)
      } else {
        onError(message ?? .empty)
      }
    }
  }
}
