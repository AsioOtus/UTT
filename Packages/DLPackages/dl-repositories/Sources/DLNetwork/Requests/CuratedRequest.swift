//
//  CuratedRequest.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation
import NetworkUtil

public struct CuratedRequest: Request {
	public let page: Int
	public let perPage: Int

	public var configuration: RequestConfiguration {
		.init()
			.setScheme("https")
			.setHost("api.pexels.com")
			.setPath("v1/curated")
			.addQueryItem(.init(name: "page", value: page.description))
			.addQueryItem(.init(name: "per_page", value: perPage.description))
	}

	public init (page: Int, perPage: Int) {
		self.page = page
		self.perPage = perPage
	}
}

extension CuratedRequest {
	public struct ResponseModel: Decodable {
		public let page: Int
		public let perPage: Int
		public let photos: [Photo]
		public let nextPage: URL?
		public let prevPage: URL?

		public init (
			page: Int,
			perPage: Int,
			photos: [Photo],
			nextPage: URL?,
			prevPage: URL?
		) {
			self.page = page
			self.perPage = perPage
			self.photos = photos
			self.nextPage = nextPage
			self.prevPage = prevPage
		}

		public enum CodingKeys: String, CodingKey {
			case page
			case perPage = "per_page"
			case photos
			case nextPage = "next_page"
			case prevPage = "prev_page"
		}
	}
}

extension CuratedRequest.ResponseModel {
	public struct Photo: Decodable {
		public let id: Int
		public let photographer: String
		public let src: Source

		public init (
			id: Int,
			photographer: String,
			src: Source
		) {
			self.id = id
			self.photographer = photographer
			self.src = src
		}
	}
}

extension CuratedRequest.ResponseModel.Photo {
	public struct Source: Decodable {
		public let original: URL
		public let large: URL

		public init (
			original: URL,
			large: URL
		) {
			self.original = original
			self.large = large
		}
	}
}
