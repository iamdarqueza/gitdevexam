//
//  DeveloperListResponse.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

// MARK: - DeveloperListResponseElement
struct DeveloperListResponseElement: Codable {
  let login: String
  let id: Int
  let nodeID: String
  let avatarURL: String
  let gravatarID: String
  let url: String
  let htmlURL: String
  let followersURL: String
  let gistsURL: String
  let starredURL: String
  let subscriptionsURL: String
  let organizationsURL: String
  let reposURL: String
  let eventsURL: String
  let receivedEventsURL: String
  let type: String
  let siteAdmin: Bool

  enum CodingKeys: String, CodingKey {
    case login
    case id
    case nodeID = "node_id"
    case avatarURL = "avatar_url"
    case gravatarID = "gravatar_id"
    case url
    case htmlURL = "html_url"
    case followersURL = "followers_url"
    case gistsURL = "gists_url"
    case starredURL = "starred_url"
    case subscriptionsURL = "subscriptions_url"
    case organizationsURL = "organizations_url"
    case reposURL = "repos_url"
    case eventsURL = "events_url"
    case receivedEventsURL = "received_events_url"
    case type
    case siteAdmin = "site_admin"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    login = try values.decodeIfPresent(String.self, forKey: .login) ?? .empty
    id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
    nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID) ?? .empty
    avatarURL = try values.decodeIfPresent(String.self, forKey: .avatarURL) ?? .empty
    gravatarID = try values.decodeIfPresent(String.self, forKey: .gravatarID) ?? .empty
    url = try values.decodeIfPresent(String.self, forKey: .url) ?? .empty
    htmlURL = try values.decodeIfPresent(String.self, forKey: .htmlURL) ?? .empty
    followersURL = try values.decodeIfPresent(String.self, forKey: .followersURL) ?? .empty
    gistsURL = try values.decodeIfPresent(String.self, forKey: .gistsURL) ?? .empty
    starredURL = try values.decodeIfPresent(String.self, forKey: .starredURL) ?? .empty
    subscriptionsURL = try values.decodeIfPresent(String.self, forKey: .subscriptionsURL) ?? .empty
    organizationsURL = try values.decodeIfPresent(String.self, forKey: .organizationsURL) ?? .empty
    reposURL = try values.decodeIfPresent(String.self, forKey: .reposURL) ?? .empty
    eventsURL = try values.decodeIfPresent(String.self, forKey: .eventsURL) ?? .empty
    receivedEventsURL = try values.decodeIfPresent(String.self, forKey: .receivedEventsURL) ?? .empty
    type = try values.decodeIfPresent(String.self, forKey: .type) ?? .empty
    siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
  }
}

typealias DeveloperListResponse = [Devs]
