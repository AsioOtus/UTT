//
//  CoreDataPersistentController.swift
//  dl-repositories
//
//  Created by Anton on 24/11/2024.
//

import CoreData

public final class CoreDataPersistentController {
	public static let `default` = CoreDataPersistentController()

	let persistentContainer = CoreDataPersistentController.createPersistentContainer()

	public func saveInBackgroundContext (
		_ action: (NSManagedObjectContext) throws -> Void
	) throws {
		let context = persistentContainer.newBackgroundContext()
		try action(context)
		try context.save()
	}

	public func saveInBackgroundContext <Entity> (
		_ type: Entity.Type,
		id: Int,
		_ action: (Entity?, NSManagedObjectContext) throws -> Void
	) throws where Entity: NSManagedObject, Entity: DBEntity {
		let context = persistentContainer.newBackgroundContext()
		let entity = try load(type, id: id, context: context)
		try action(entity, context)
		try context.save()
	}

	public func load <Entity> (
		_ type: Entity.Type,
		page: Int?,
		pageSize: Int?,
		predicate: NSPredicate?,
		sortDescriptors: [NSSortDescriptor] = []
	) throws -> [Entity] where Entity: NSManagedObject, Entity: DBEntity {
		let fetchRequest = Entity.entityFetchRequest()
		fetchRequest.predicate = predicate
		if let pageSize {
			fetchRequest.fetchLimit = pageSize

			if let page {
				fetchRequest.fetchOffset = page * pageSize
			}
		}
		fetchRequest.sortDescriptors = sortDescriptors

		let context = persistentContainer.viewContext
		let objects = try context.fetch(fetchRequest)

		return objects
	}

	public func load <Entity> (
		_ type: Entity.Type,
		predicate: NSPredicate?
	) throws -> [Entity] where Entity: NSManagedObject, Entity: DBEntity {
		let fetchRequest = Entity.entityFetchRequest()
		fetchRequest.predicate = predicate

		let context = persistentContainer.viewContext
		let objects = try context.fetch(fetchRequest)

		return objects
	}

	public func load <Entity> (
		_ type: Entity.Type,
		id: Int,
		context: NSManagedObjectContext? = nil
	) throws -> Entity? where Entity: NSManagedObject, Entity: DBEntity {
		let fetchRequest = Entity.entityFetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", id.description)
		fetchRequest.fetchLimit = 1

		let context = context ?? persistentContainer.viewContext
		let object = try context.fetch(fetchRequest).first

		return object
	}

	public func find <Entity> (
		_ type: Entity.Type,
		id: Int,
		context: NSManagedObjectContext? = nil
	) throws -> Entity where Entity: NSManagedObject, Entity: DBEntity {
		guard let object = try load(Entity.self, id: id, context: context) else {
			throw PersistenceError.relatedEntityNotFound(id: id, entity: Entity.description())
		}

		return object
	}

	public func delete <Entity> (
		_ type: Entity.Type,
		id: Int,
		context: NSManagedObjectContext? = nil
	) throws where Entity: NSManagedObject, Entity: DBEntity {
		let context = context ?? persistentContainer.newBackgroundContext()

		do {
			let entity = try find(type, id: id, context: context)
			context.delete(entity)
			try context.save()
		} catch {
			context.rollback()
			throw error
		}
	}

	public func clear () {
		let context = persistentContainer.newBackgroundContext()
		let entityNames = persistentContainer.managedObjectModel.entitiesByName.keys

		for entityName in entityNames {
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
			let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

			do {
				try context.execute(deleteRequest)
			} catch {
				print("Failed to delete all objects in entity \(entityName): \(error)")
			}
		}
	}
}

extension CoreDataPersistentController {
	static func createPersistentContainer () -> NSPersistentContainer {
		let container = NSPersistentContainer(name: "db")
		container.loadPersistentStores { (_, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}

		return container
	}
}
