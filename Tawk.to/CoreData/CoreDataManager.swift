//
//  CoreDataManager.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import CoreData

// MARK: - Singleton Core Data Manager

class CoreDataManager {
  static let shared = CoreDataManager()

  // MARK: - Core Data Setup NSPersistentContainer

  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "CoreDataDevs")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true

    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()

  // MARK: - ManagedObject

  lazy var managedObject: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()

  // MARK: - Core Data Saving

  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func applicationDocumentsDirectory() {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(urls[urls.count - 1] as URL)
  }

  func getLastIndexId() -> Devs? {
    let fetch = NSFetchRequest<Devs>(entityName: "Devs")
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    fetch.sortDescriptors = [sortDescriptor]

    do {
      let devs = try managedObject.fetch(fetch)
      return devs.last
    } catch let error {
      print(error)
    }

    return nil
  }

  func checkDevIsEmpty(entity: String) -> Bool {
    let fetch = NSFetchRequest<Devs>(entityName: "Devs")

    do {
      let devs = try managedObject.fetch(fetch)
      return devs.count == 0
    } catch let error {
      print(error)
    }
    return false
  }

  func clearAllDevs() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Devs")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try managedObject.execute(batchDeleteRequest)
    } catch let error as NSError {
      print(error)
    }
  }

  func saveNotes(dev: DeveloperProfileResponse, notes: String, onSuccess: @escaping SingleResult<Bool>) {
    let newNotes = DevNotes(context: managedObject)
    newNotes.id = Int32(dev.id)
    newNotes.notes = notes
    print("NOTE: \(notes)")
    let fetch = NSFetchRequest<Devs>(entityName: "Devs")

    let predicate = NSPredicate(format: "id = '\(dev.id)'")
    fetch.predicate = predicate
    do {
      let result = try managedObject.fetch(fetch)
      if let objectToUpdate = result.first {
        objectToUpdate.setValue(notes, forKey: "notes")
      }
    } catch {
      print(error)
    }
    saveContext()
    onSuccess(true)
  }

  func thereIsNotes(id: Int) -> Bool {
    let fetch = NSFetchRequest<DevNotes>(entityName: "DevNotes")

    let predicate = NSPredicate(format: "id = '\(id)'")
    fetch.predicate = predicate
    do {
      let result = try managedObject.fetch(fetch)
      if let item = result.first {
        if let note = item.notes {
          return note.isEmpty ? false : true
        }
      }
    } catch {
      print(error)
    }
    return false
  }

  func getNotesById(id: Int) -> String {
    let fetch = NSFetchRequest<Devs>(entityName: "Devs")

    let predicate = NSPredicate(format: "id = '\(id)'")
    fetch.predicate = predicate
    do {
      let result = try managedObject.fetch(fetch)
      if let item = result.first {
        if let note = item.notes {
          return note
        }
      }
    } catch {
      print(error)
    }
    return .empty
  }
  
  func getUsers() -> [Devs] {
    let fetch = NSFetchRequest<Devs>(entityName: "Devs")
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    fetch.sortDescriptors = [sortDescriptor]
    
    do {
        let users = try managedObject.fetch(fetch)
        return users
    } catch let error {
        print(error)
    }
    
    return []

  }
}
