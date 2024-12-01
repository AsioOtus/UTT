//
//  Bundle+info.swift
//  dl-logic
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public extension Bundle {
	var pexelsToken: String {
		guard let token = object(forInfoDictionaryKey: "PexelsToken") as? String
		else { fatalError() }

		return token
	}
}

