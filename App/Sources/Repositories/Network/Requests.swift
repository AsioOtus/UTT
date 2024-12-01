//
//  Requests.swift
//  App
//
//  Created by Anton on 01/12/2024.
//

import Foundation

enum Requests {
	private static func baseUrlComponents () -> URLComponents {
		.init(string: "https://api.pexels.com/v1")!
	}

	static func curated (page: Int, perPage: Int) -> URLRequest {
		var urlComponents = baseUrlComponents()
		urlComponents.path.append("/curated")
		urlComponents.queryItems = [
			.init(name: "page", value: page.description),
			.init(name: "per_page", value: perPage.description),
		]

		let urlRequest = URLRequest(url: urlComponents.url!)
		return urlRequest
	}

	static func nextCurated (_ url: URL) -> URLRequest {
		.init(url: url)
	}

	static func photo (_ id: Int) -> URLRequest {
		var urlComponents = baseUrlComponents()
		urlComponents.path.append("/photos/\(id)")
		let urlRequest = URLRequest(url: urlComponents.url!)
		return urlRequest
	}
}
