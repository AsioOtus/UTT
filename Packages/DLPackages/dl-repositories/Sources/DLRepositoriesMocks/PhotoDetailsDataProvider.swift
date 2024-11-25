//
//  PhotoDetailsDataProvider.swift
//  dl-repositories
//
//  Created by Anton on 25/11/2024.
//

import DLEntities
import DLUseCasesDataProvidersProtocols
import Foundation

extension Mock {
	public final class PhotoDetailsDataProvider: PPhotoDetailsDataProvider {
		public let stubValue: PhotoEntity

		public init (stubValue: PhotoEntity) {
			self.stubValue = stubValue
		}

		public func loadPhoto (id: Int) async throws -> PhotoEntity {
			stubValue
		}
	}
}

extension Mock.Throwing {
	public final class PhotoDetailsDataProvider: PPhotoDetailsDataProvider {
		public let error: Error?

		public init (error: Error? = nil) {
			self.error = error
		}

		public func loadPhoto (id: Int) async throws -> PhotoEntity {
			throw (error ?? TestError.instance)
		}
	}
}
