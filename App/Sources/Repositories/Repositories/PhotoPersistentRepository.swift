//
//  PhotoPersistentRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotoPersistentRepository: PPhotoDetailsPersistentDataProvider {
	let dbController = CoreDataPersistentController.default

	public func savePhoto (_ photoEntity: PhotoEntity) throws {
		try dbController.saveInBackgroundContext(PhotoDBEntity.self, id: photoEntity.id) { photo, context in
			(photo ?? PhotoDBEntity(context: context))
				.set(
					id: photoEntity.id,
					createdAt: .init(),
					author: photoEntity.photographerName,
					alt: photoEntity.description,
					width: photoEntity.width,
					height: photoEntity.height,
					originalUrl: photoEntity.originalUrl,
					largeUrl: photoEntity.largeUrl
				)
		}
	}

	public func savePhotos (_ photoEntities: [PhotoEntity]) throws {
		try dbController.saveInBackgroundContext { context in
			try photoEntities.forEach { photoEntity in
				let photo = try dbController.load(PhotoDBEntity.self, id: photoEntity.id, context: context)

				(photo ?? PhotoDBEntity(context: context))
					.set(
						id: photoEntity.id,
						createdAt: .init(),
						author: photoEntity.photographerName,
						alt: photoEntity.description,
						width: photoEntity.width,
						height: photoEntity.height,
						originalUrl: photoEntity.originalUrl,
						largeUrl: photoEntity.largeUrl
					)
			}
		}
	}

	public func loadPhoto (id: Int) throws -> PhotoEntity? {
		let photo = try dbController.load(PhotoDBEntity.self, id: id)
		let photoEntity = photo.map(map)
		return photoEntity
	}
}

private extension PhotoPersistentRepository {
	func map (_ photo: PhotoDBEntity) -> PhotoEntity {
		.init(
			id: photo.id.intValue,
			photographerName: photo.author,
			description: photo.alt,
			width: photo.width.intValue,
			height: photo.height.intValue,
			originalUrl: photo.originalUrl,
			largeUrl: photo.largeUrl
		)
	}
}
