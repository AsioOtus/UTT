//
//  PhotoDetailsRepository.swift
//  dl-repositories
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public struct PhotoDetailsRepository: PPhotoDetailsDataProvider {
	let networkController = NetworkController()

	public func loadPhoto (id: Int) async throws -> PhotoEntity {
		try await networkController.send(Requests.photo(id), responseType: Photo.self).entity
	}
}
