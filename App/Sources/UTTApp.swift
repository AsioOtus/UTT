//
//  UTTApp.swift
//  UTT
//
//  Created by Anton on 20/11/2024.
//

import Dependencies
import Kingfisher
import SwiftUI

@main
struct UTTApp: App {
	@Dependency(\.urlClient) var urlClient

	init () {
		Task { [self] in
			for await log in urlClient.logs {
				log.message.urlRequest?.url.map { print($0) }
//				dump(log)
			}
		}

		configureUrlCache()
		configureImageCache()
	}

	var body: some Scene {
		WindowGroup {
			RootView()
		}
	}
}

private extension UTTApp {
	func configureUrlCache () {
		let cacheSizeMemory = 50 * 1024 * 1024 // 50 MB
		let cacheSizeDisk = 100 * 1024 * 1024 // 100 MB

		let urlCache = URLCache(
			memoryCapacity: cacheSizeMemory,
			diskCapacity: cacheSizeDisk
		)

		URLCache.shared = urlCache
	}

	func configureImageCache () {
		ImageCache.default.memoryStorage.config.totalCostLimit = 2000
		ImageCache.default.memoryStorage.config.expiration = .days(3)
		ImageCache.default.diskStorage.config.sizeLimit = 1_000_000_000
	}
}
