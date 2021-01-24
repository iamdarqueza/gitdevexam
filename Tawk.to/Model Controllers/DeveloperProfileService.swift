//
//  DeveloperProfileService.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/23/21.
//

import Foundation

// MARK: - DeveloperProfileService Protocol
protocol DeveloperProfileServiceProtocol {
  func getDeveloperProfile(username: String, onHandleCompletion: @escaping ResultClosure<DeveloperProfileResponse>)
}

final class DeveloperProfileService: BaseService, DeveloperProfileServiceProtocol {
  // MARK: - Request Dev Details
  func getDeveloperProfile(username: String, onHandleCompletion: @escaping ResultClosure<DeveloperProfileResponse>) {
    
    let url: URL! = URL(string: "https://api.github.com/users/\(username)")
    var uriRequest = URLRequest(url: url)
    uriRequest.httpMethod = RestVerbs.GET.rawValue

    consumeAPI(
      DeveloperProfileResponse.self,
      request: uriRequest,
      completion: { result, err in
        guard err == nil else {
          return onHandleCompletion(nil, false, err?.localizedDescription)
        }
        onHandleCompletion(result, true, err?.localizedDescription)
      }
    )
  }
}
