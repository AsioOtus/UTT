//
//  PPhotoDetailsPersistentDataProvider.swift.swift
//  dl-use-cases-protocols
//
//  Created by Anton on 21/11/2024.
//

import DLEntities
import Foundation

public protocol PPhotoDetailsPersistentDataProvider {
	func savePhoto (_ photoEntity: PhotoEntity) throws
	func savePhotos (_ photoEntities: [PhotoEntity]) throws
	func loadPhoto (id: Int) throws -> PhotoEntity?
}
