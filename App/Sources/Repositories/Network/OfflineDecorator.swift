//
//  OfflineDecorator.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import NetworkUtil

struct OfflineDecorator: URLClientDecorator {
	let urlClient: URLClient
 
	func send <RQ: Request, RS: Response> (
		_ request: RQ,
		response: RS.Type,
		delegate: some URLClientSendingDelegate<RQ, RS.Model>,
		configurationUpdate: RequestConfiguration.Update? = nil
	) async throws -> RS {
		try await urlClient.send(
			request,
			response: response,
			delegate: .standard(
					sending: { _, _ in throw URLError(.cannotConnectToHost) }
				)
				.merge(with: delegate),
			configurationUpdate: configurationUpdate
		)
	}
}

extension URLClient {
	func offline () -> OfflineDecorator {
		.init(urlClient: self)
	}
}

