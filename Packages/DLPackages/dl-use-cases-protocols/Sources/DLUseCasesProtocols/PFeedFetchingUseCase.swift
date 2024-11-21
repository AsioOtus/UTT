//
//  PFeedFetchingUseCase.swift
//  dl-use-cases-protocols
//
//  Created by Anton on 21/11/2024.
//

import DLEntities
import Foundation

public protocol PFeedFetchingUseCase {
	func fetchPhotosFragment (perPage: Int) async throws -> PhotosFragmentEntity
	func fetchPhotosFragment (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity
}

