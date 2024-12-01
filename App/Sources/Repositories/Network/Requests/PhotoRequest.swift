//
//  PhotoRequest.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import NetworkUtil

public struct PhotoRequest: Request {
	public let id: Int

	public var configuration: RequestConfiguration {
		.init()
			.setScheme("https")
			.setHost("api.pexels.com")
			.setPath("v1/photos/\(id)")
	}

	public init (id: Int) {
		self.id = id
	}
}
