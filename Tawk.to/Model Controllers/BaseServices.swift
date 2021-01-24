//
//  BaseServices.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

class BaseService {
  let urlSession: URLSession

  init() {
    urlSession = URLSession(configuration: .default)
  }

  func consumeAPI<T: Decodable>(_ decodableType: T.Type, request: URLRequest, completion: OnCompletionHandler<T>? = nil) {
    let dataTask = urlSession.dataTask(with: request) { data, response, error in
      guard let uriResponse = response as? HTTPURLResponse else {
        completion?(nil, error)
        return
      }

      let successRange = 200 ... 299
      if successRange.contains(uriResponse.statusCode) {
        guard let responseData = data else { return }

        do {
          guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Error Core Data")
            return
          }
          let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

          let decoder = JSONDecoder()
          debugPrint(decoder.userInfo)
          decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
          let value = try decoder.decode(T.self, from: responseData)
          completion?(value, nil)
        } catch let jsonError {
          debugPrint("error \(jsonError)")
        }
      } else {
        completion?(nil, error)
      }
    }
    dataTask.resume()
  }
}
