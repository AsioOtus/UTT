//
//  CacheCleanupMenu.swift
//  il-components
//
//  Created by Anton on 21/11/2024.
//

import Kingfisher
import SwiftUI

public struct CacheCleanupMenuView: View {
	public init () { }

	public var body: some View {
		Menu("Settings", systemImage: "gear") {
			Section("Data cleanup") {
				Button("Clear thumbnails memory cache", systemImage: "memorychip") {
					ImageCache.default.memoryStorage.removeAll()
				}

				Button("Clear thumbnails disk cache", systemImage: "externaldrive") {
					try? ImageCache.default.diskStorage.removeAll()
				}

				Button("Clear all thumbnails cache", systemImage: "photo.stack") {
					ImageCache.default.memoryStorage.removeAll()
					try? ImageCache.default.diskStorage.removeAll()
				}

				Button("Clear URLSession cache", systemImage: "network") {
					URLCache.shared.removeAllCachedResponses()
				}

				Divider()

				Button("Clear all cache", systemImage: "trash") {
					ImageCache.default.memoryStorage.removeAll()
					try? ImageCache.default.diskStorage.removeAll()

					URLCache.shared.removeAllCachedResponses()
				}
			}
		}
		.symbolVariant(.fill)
	}
}
