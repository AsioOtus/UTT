//
//  OfflineError.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

@dynamicMemberLookup
public struct OfflineError: Error {
	public let error: Error

	public init (error: Error) {
		self.error = error
	}

	public subscript <Value> (dynamicMember keyPath: KeyPath<Error, Value>) -> Value {
		error[keyPath: keyPath]
	}
}

