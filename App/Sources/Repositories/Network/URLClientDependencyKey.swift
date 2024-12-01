//
//  NetworkControllerDependencyKey.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import Foundation
import NetworkUtil

public enum URLClientDependencyKey: DependencyKey {
	public static var liveValue: any URLClient {
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .returnCacheDataElseLoad
		let urlSession = URLSession(configuration: configuration)

		return StandardURLClient(
			configuration: .init(
				headers: [
					"Authorization": Bundle.main.pexelsToken
				]
			),
			delegate: .standard(urlSessionBuilder: urlSession)
		)
		.networkConnectivityDetector()
	}
}

public extension DependencyValues {
	var urlClient: any URLClient {
		get { self[URLClientDependencyKey.self] }
		set { self[URLClientDependencyKey.self] = newValue }
	}
}
