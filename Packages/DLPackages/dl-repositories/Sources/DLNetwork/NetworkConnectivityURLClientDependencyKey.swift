//
//  NetworkConnectivityURLClientDecorator.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Dependencies
import DLEntities
import Foundation
import NetworkUtil

public struct NetworkConnectivityURLClientDecorator: URLClientDecorator {
	public static let offlineUrlErrorCodes: [URLError.Code] = [
		.backgroundSessionInUseByAnotherProcess,
		.cannotFindHost,
		.cannotConnectToHost,
		.networkConnectionLost,
		.notConnectedToInternet,
		.secureConnectionFailed,
		.timedOut,
	]

	public let urlClient: URLClient

	init (urlClient: URLClient) {
		self.urlClient = urlClient
	}

	public func send <RQ: Request, RS: Response>(
		_ request: RQ,
		response: RS.Type,
		delegate: some URLClientSendingDelegate<RQ, RS.Model>,
		configurationUpdate: RequestConfiguration.Update?
	) async throws -> RS {
		try await urlClient.send(
			request,
			response: response,
			delegate: .standard(
				sending: self.sending
			).merge(with: delegate),
			configurationUpdate: configurationUpdate
		)
	}

	func sending <RQ: Request> (
		_ sendingModel: SendingModel<RQ>,
		_ sendingAction: SendAction<RQ>
	) async throws -> (Data, URLResponse) {
		do {
			let (data, urlResponse) = try await sendingAction(sendingModel.urlSession, sendingModel.urlRequest)
			return (data, urlResponse)
		} catch let urlError as URLError {
			let isOffline = Self.offlineUrlErrorCodes.contains(urlError.code)

			if isOffline {
				throw OfflineTriggerError(error: urlError)
			} else {
				throw urlError
			}
		}
	}
}

public extension URLClient {
	func networkConnectivityDetector () -> NetworkConnectivityURLClientDecorator {
		.init(urlClient: self)
	}
}

