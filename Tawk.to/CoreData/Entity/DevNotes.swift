//
//  DevNotes.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import Foundation
import CoreData

// MARK: - Devnotes Entity

@objc(DevNotes)
public class DevNotes: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DevNotes> {
      return NSFetchRequest<DevNotes>(entityName: "DevNotes")
  }

  @NSManaged public var id: Int32
  @NSManaged public var notes: String?
}
