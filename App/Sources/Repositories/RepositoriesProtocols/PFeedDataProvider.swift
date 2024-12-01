//
//  PFeedDataProvider.swift
//  dl-use-cases-protocols
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public protocol PFeedDataProvider {
	func load (photosPerPage: Int) async throws -> PhotosFragmentEntity
	func load (nextFragmentUrl: URL) async throws -> PhotosFragmentEntity
}
