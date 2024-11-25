//
//  PhotoDetailsPersistentDataProvider.swift
//  dl-repositories
//
//  Created by Anton on 25/11/2024.
//

import DLEntities
import DLUseCasesDataProvidersProtocols
import Foundation

extension Mock {
	public final class PhotoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider {
		public let stubValue: PhotoEntity

		public init (stubValue: PhotoEntity) {
			self.stubValue = stubValue
		}

		public func savePhoto(_ photoEntity: PhotoEntity) throws { }

		public func savePhotos(_ photoEntities: [PhotoEntity]) throws { }

		public func loadPhoto(id: Int) throws -> PhotoEntity? {
			stubValue
		}
	}
}

extension Mock.Throwing {
	public final class PhotoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider {
		public init () { }

		public func savePhoto(_ photoEntity: PhotoEntity) throws {
			throw TestError.instance
		}

		public func savePhotos(_ photoEntities: [PhotoEntity]) throws {
			throw TestError.instance
		}

		public func loadPhoto(id: Int) throws -> PhotoEntity? {
			throw TestError.instance
		}
	}
}


