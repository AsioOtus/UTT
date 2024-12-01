//
//  NextCuratedRequest.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import NetworkUtil

public struct NextCuratedRequest: Request {
	public let addressUrl: URL

	public var address: String? {
		addressUrl.absoluteString
	}

	public init (addressUrl: URL) {
		self.addressUrl = addressUrl
	}
}
