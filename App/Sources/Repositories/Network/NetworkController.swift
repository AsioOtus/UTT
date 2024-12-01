//
//  NetworkController.swift
//  App
//
//  Created by Anton on 01/12/2024.
//

import Foundation

struct NetworkController {
	let urlSession: URLSession = {
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .returnCacheDataElseLoad
		return URLSession(configuration: configuration)
	}()

	let decoder = JSONDecoder()

	func send <Response> (_ urlRequest: URLRequest, responseType: Response.Type) async throws -> Response where Response: Decodable {
		var urlRequest = urlRequest

		urlRequest.addValue(Bundle.main.pexelsToken, forHTTPHeaderField: "Authorization")

		print(urlRequest)

		let (data, _) = try await urlSession.data(for: urlRequest)
		let response = try decoder.decode(Response.self, from: data)
		return response
	}
}
