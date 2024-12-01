//
//  PersistenceError.swift
//  dl-repositories
//
//  Created by Anton on 24/11/2024.
//

import Foundation

public enum PersistenceError: Error {
	case entityNotFound(id: Int, entity: String)
	case relatedEntityNotFound(id: Int, entity: String)
	case integrityFault(String)
}

