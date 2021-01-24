//
//  Devs.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import CoreData
import Foundation

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

// MARK: - Devs Entity

@objc(Devs)

public class Devs: NSManagedObject, Codable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Devs> {
    return NSFetchRequest<Devs>(entityName: "Devs")
  }

  @NSManaged public var login: String?
  @NSManaged public var id: Int32
  @NSManaged public var nodeID: String?
  @NSManaged public var attribute: String?
  @NSManaged public var gravatarID: String?
  @NSManaged public var url: String?
  @NSManaged public var htmlURL: String?
  @NSManaged public var followersURL: String?
  @NSManaged public var gistsURL: String?
  @NSManaged public var starredURL: String?
  @NSManaged public var subscriptionsURL: String?
  @NSManaged public var organizationsURL: String?
  @NSManaged public var reposURL: String?
  @NSManaged public var eventsURL: String?
  @NSManaged public var receivedEventsURL: String?
  @NSManaged public var type: String?
  @NSManaged public var siteAdmin: Bool
  @NSManaged public var avatarURL: String?
  @NSManaged public var notes: String?

  public required convenience init(from decoder: Decoder) throws {
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "Devs", in: managedObjectContext) else {
      fatalError("Failed to decode User")
    }

    self.init(entity: entity, insertInto: managedObjectContext)
    let values = try decoder.container(keyedBy: CodingKeys.self)
    do {
      login = try values.decodeIfPresent(String.self, forKey: .login) ?? .empty
      id = Int32(try values.decodeIfPresent(Int.self, forKey: .id) ?? -1)
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
      notes = try values.decodeIfPresent(String.self, forKey: .notes) ?? .empty


    } catch {
      print("error")
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(login, forKey: .login)
    try container.encode(id, forKey: .id)
    try container.encode(nodeID, forKey: .nodeID)
    try container.encode(avatarURL, forKey: .avatarURL)
    try container.encode(gravatarID, forKey: .gravatarID)
    try container.encode(url, forKey: .url)
    try container.encode(htmlURL, forKey: .htmlURL)
    try container.encode(followersURL, forKey: .followersURL)
    try container.encode(gistsURL, forKey: .gistsURL)
    try container.encode(starredURL, forKey: .starredURL)
    try container.encode(subscriptionsURL, forKey: .subscriptionsURL)
    try container.encode(organizationsURL, forKey: .organizationsURL)
    try container.encode(reposURL, forKey: .reposURL)
    try container.encode(eventsURL, forKey: .eventsURL)
    try container.encode(receivedEventsURL, forKey: .receivedEventsURL)
    try container.encode(type, forKey: .type)
    try container.encode(siteAdmin, forKey: .siteAdmin)
    try container.encode(notes, forKey: .notes)

  }

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
    case notes = "notes"

  }
}
