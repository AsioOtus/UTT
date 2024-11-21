//
//  FeedDataProvider.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import DLEntities
import DLUseCasesDataProvidersProtocols
import Foundation

extension Mock {
	public final class FeedDataProvider: PFeedDataProvider {
		public let stubValue: PhotosFragmentEntity

		public init (stubValue: PhotosFragmentEntity) {
			self.stubValue = stubValue
		}

		public var paramPhotosPerPage: Int?
		public func load (photosPerPage: Int) async throws -> PhotosFragmentEntity {
			paramPhotosPerPage = photosPerPage
			return stubValue
		}

		public var paramNextFragmentUrl: URL?
		public func load (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
			paramNextFragmentUrl = nextFragmentUrl
			return stubValue
		}
	}
}

extension Mock.Throwing {
	public final class FeedDataProvider: PFeedDataProvider {
		public init () { }

		public func load (photosPerPage: Int) async throws -> PhotosFragmentEntity {
			throw TestError.instance
		}

		public func load (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity {
			throw TestError.instance
		}
	}
}

