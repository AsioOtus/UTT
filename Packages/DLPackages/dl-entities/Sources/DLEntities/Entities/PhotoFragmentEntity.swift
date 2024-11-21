//
//  PhotosFragmentEntity.swift
//  dl-entities
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotosFragmentEntity: Equatable {
	public let page: Int
	public let photosPerPage: Int
	public let photos: [PhotoEntity]
	public let previousFragmentUrl: URL?
	public let nextFragmentUrl: URL?

	public var isFirst: Bool { previousFragmentUrl == nil }
	public var isLast: Bool { nextFragmentUrl == nil }

	public init (
		page: Int,
		photosPerPage: Int,
		photos: [PhotoEntity],
		previousFragmentUrl: URL?,
		nextFragmentUrl: URL?
	) {
		self.page = page
		self.photosPerPage = photosPerPage
		self.photos = photos
		self.previousFragmentUrl = previousFragmentUrl
		self.nextFragmentUrl = nextFragmentUrl
	}
}
