//
//  PPhotoDetailsDataProvider.swift
//  dl-use-cases-protocols
//
//  Created by Anton on 21/11/2024.
//

import Foundation

public protocol PPhotoDetailsDataProvider {
	func loadPhoto (id: Int) async throws -> PhotoEntity
}
