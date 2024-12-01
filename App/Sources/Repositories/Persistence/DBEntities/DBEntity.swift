//
//  DBEntity.swift
//  dl-repositories
//
//  Created by Anton on 24/11/2024.
//

import CoreData

@objc
public protocol DBEntity where Self: NSManagedObject { }

public extension DBEntity {
	static var entityName: String {
		.init(describing: Self.self)
	}

	static func entityFetchRequest () -> NSFetchRequest<Self> {
		.init(entityName: entityName)
	}
}
