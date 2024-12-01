//
//  PhotoDetailsPersistentDataProvider.swift
//  dl-repositories
//
//  Created by Anton on 25/11/2024.
//

import Foundation

extension Mock {
	public final class PhotoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider {
		public let stubValue: PhotoEntity

		public init (stubValue: PhotoEntity) {
			self.stubValue = stubValue
		}

		public var paramPhotoEntity: PhotoEntity?
		public func savePhoto (_ photoEntity: PhotoEntity) throws {
			paramPhotoEntity = photoEntity
		}

		public var paramPhotoEntities: [PhotoEntity]?
		public func savePhotos (_ photoEntities: [PhotoEntity]) throws {
			paramPhotoEntities = photoEntities
		}

		public func loadPhoto (id: Int) throws -> PhotoEntity? {
			stubValue
		}
	}
}

extension Mock.Throwing {
	public final class PhotoDetailsPersistentDataProvider: PPhotoDetailsPersistentDataProvider {
		public let error: Error?

		public init (error: Error? = nil) {
			self.error = error
		}

		public func savePhoto (_ photoEntity: PhotoEntity) throws {
			throw (error ?? TestError.instance)
		}

		public func savePhotos (_ photoEntities: [PhotoEntity]) throws {
			throw (error ?? TestError.instance)
		}

		public func loadPhoto (id: Int) throws -> PhotoEntity? {
			throw (error ?? TestError.instance)
		}
	}
}


