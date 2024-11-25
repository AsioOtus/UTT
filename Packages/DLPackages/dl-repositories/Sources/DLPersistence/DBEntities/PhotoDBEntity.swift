//
//  PhotoDBEntity.swift
//  dl-repositories
//
//  Created by Anton on 24/11/2024.
//

import Foundation
import CoreData

@objc
public class PhotoDBEntity: NSManagedObject, DBEntity {
	@discardableResult
	public func set (
		id: Int,
		createdAt: Date,
		author: String,
		alt: String,
		width: Int,
		height: Int,
		originalUrl: URL,
		largeUrl: URL
	) -> Self {
		self.id = NSNumber.init(value: id)
		self.createdAt = createdAt
		self.author = author
		self.alt = alt
		self.width = NSNumber.init(value: width)
		self.height = NSNumber.init(value: height)
		self.originalUrl = originalUrl
		self.largeUrl = largeUrl

		return self
	}

	@objc
	private override init (entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
}

extension PhotoDBEntity {
	public static func fetchRequest() -> NSFetchRequest<PhotoDBEntity> { .init(entityName: entityName) }

	@NSManaged public var id: NSNumber
	@NSManaged public var createdAt: Date
	@NSManaged public var author: String
	@NSManaged public var alt: String
	@NSManaged public var width: NSNumber
	@NSManaged public var height: NSNumber
	@NSManaged public var originalUrl: URL
	@NSManaged public var largeUrl: URL
}
