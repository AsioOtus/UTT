//
//  NetworkControllerDependencyKey.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLLogic
import Foundation
import NetworkUtil

public enum NetworkControllerDependencyKey: DependencyKey {
	public static var liveValue: any FullScaleNetworkController {
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .reloadRevalidatingCacheData
		let urlSession = URLSession(configuration: configuration)

		return StandardNetworkController(
			configuration: .init(
				address: "",
				headers: [
					"Authorization": Bundle.main.pexelsToken
				]
			),
			delegate: .delegate(urlSessionBuilder: urlSession)
		)
	}
}

public extension DependencyValues {
	var networkController: any FullScaleNetworkController {
		get { self[NetworkControllerDependencyKey.self] }
		set { self[NetworkControllerDependencyKey.self] = newValue }
	}
}
