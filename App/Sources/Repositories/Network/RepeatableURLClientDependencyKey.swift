//
//  RepeatableNetworkControllerDependencyKey.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import NetworkUtil

public enum RepeatableURLClientDependencyKey: DependencyKey {
	public static var liveValue: any URLClient {
		@Dependency(\.urlClient) var urlClient

		return urlClient
			.repeatable(
				maxAttempts: 10,
				delayStrategy: DelayProgressions.exponent(),
				errorHandler: { error, _, _ in
					if error is OfflineError {
						throw error
					}
				}
			)
	}
}

public extension DependencyValues {
	var repeatableUrlClient: any URLClient {
		get { self[RepeatableURLClientDependencyKey.self] }
		set { self[RepeatableURLClientDependencyKey.self] = newValue }
	}
}
