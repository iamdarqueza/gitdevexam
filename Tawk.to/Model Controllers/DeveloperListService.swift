//
//  DeveloperListService.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

// MARK: - Protocol for DevListService
protocol DeveloperListServiceProtocol {
  func getDeveloperList(id: Int, onHandleCompletion: @escaping ResultClosure<DeveloperListResponse>)
}

// MARK: - DevListService Service for API request
final class DeveloperListService: BaseService, DeveloperListServiceProtocol {
  func getDeveloperList(id: Int, onHandleCompletion: @escaping ResultClosure<DeveloperListResponse>) {
    let url: URL! = URL(string: "https://api.github.com/users?since=\(id)")
    var uriRequest = URLRequest(url: url)
    uriRequest.httpMethod = RestVerbs.GET.rawValue
    
    consumeAPI(DeveloperListResponse.self, request: uriRequest, completion: { result, err in
        guard err == nil else {
          return onHandleCompletion(nil, false, err?.localizedDescription)
        }
        onHandleCompletion(result, true, err?.localizedDescription)
      }
    )
  }
}
