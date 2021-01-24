//
//  DevResponse.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation

// MARK: - DeveloperProfileResponse
struct DeveloperProfileResponse: Codable {
  let login: String
  let id: Int
  let nodeID: String
  let avatarURL: String
  let gravatarID: String
  let url: String
  let htmlURL: String
  let followersURL: String
  let followingURL: String
  let gistsURL: String
  let starredURL: String
  let subscriptionsURL: String
  let organizationsURL: String
  let reposURL: String
  let eventsURL: String
  let receivedEventsURL: String
  let type: String
  let siteAdmin: Bool
  let name: String
  let company: String
  let blog: String
  let location: String
  let email: String?
  let hireable: String?
  let bio: String?
  let twitterUsername: String?
  let publicRepos: Int
  let publicGists: Int
  let followers: Int
  let following: Int
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case login, id
    case nodeID = "node_id"
    case avatarURL = "avatar_url"
    case gravatarID = "gravatar_id"
    case url
    case htmlURL = "html_url"
    case followersURL = "followers_url"
    case followingURL = "following_url"
    case gistsURL = "gists_url"
    case starredURL = "starred_url"
    case subscriptionsURL = "subscriptions_url"
    case organizationsURL = "organizations_url"
    case reposURL = "repos_url"
    case eventsURL = "events_url"
    case receivedEventsURL = "received_events_url"
    case type
    case siteAdmin = "site_admin"
    case name, company, blog, location, email, hireable, bio
    case twitterUsername = "twitter_username"
    case publicRepos = "public_repos"
    case publicGists = "public_gists"
    case followers, following
    case createdAt = "created_at"
    case updatedAt = "updated_at"
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
    gistsURL = try values.decodeIfPresent(String.self, forKey: .gistsURL) ?? .empty
    starredURL = try values.decodeIfPresent(String.self, forKey: .starredURL) ?? .empty
    subscriptionsURL = try values.decodeIfPresent(String.self, forKey: .subscriptionsURL) ?? .empty
    organizationsURL = try values.decodeIfPresent(String.self, forKey: .organizationsURL) ?? .empty
    reposURL = try values.decodeIfPresent(String.self, forKey: .reposURL) ?? .empty
    eventsURL = try values.decodeIfPresent(String.self, forKey: .eventsURL) ?? .empty
    receivedEventsURL = try values.decodeIfPresent(String.self, forKey: .receivedEventsURL) ?? .empty
    type = try values.decodeIfPresent(String.self, forKey: .type) ?? .empty
    siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? .empty
    company = try values.decodeIfPresent(String.self, forKey: .company) ?? .empty
    blog = try values.decodeIfPresent(String.self, forKey: .blog) ?? .empty
    location = try values.decodeIfPresent(String.self, forKey: .location) ?? .empty
    email = try values.decodeIfPresent(String.self, forKey: .email) ?? .empty
    hireable = try values.decodeIfPresent(String.self, forKey: .hireable) ?? .empty
    bio = try values.decodeIfPresent(String.self, forKey: .bio) ?? .empty
    twitterUsername = try values.decodeIfPresent(String.self, forKey: .twitterUsername) ?? .empty
    publicRepos = try values.decodeIfPresent(Int.self, forKey: .publicRepos) ?? 0
    publicGists = try values.decodeIfPresent(Int.self, forKey: .publicGists) ?? 0
    followers = try values.decodeIfPresent(Int.self, forKey: .followers) ?? 0
    following = try values.decodeIfPresent(Int.self, forKey: .following) ?? 0
    createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? .empty
    updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? .empty
    followersURL = try values.decodeIfPresent(String.self, forKey: .followersURL) ?? .empty
    followingURL = try values.decodeIfPresent(String.self, forKey: .followingURL) ?? .empty

  }
}
