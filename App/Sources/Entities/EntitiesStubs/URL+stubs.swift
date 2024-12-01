//
//  URL+stubs.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public extension URL {
	static let stubOriginal = Self(string: "test.com/original")!
	static let stubLarge = Self(string: "test.com/large")!

	static let stubPreviousFragment = Self(string: "https://api.pexels.com/v1/curated/?page=1&per_page=5")!
	static let stubNextFragment = Self(string: "https://api.pexels.com/v1/curated/?page=2&per_page=5")!
}

