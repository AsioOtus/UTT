//
//  PPhotoDetailsFetchingUseCase.swift
//  dl-use-cases-protocols
//
//  Created by Anton on 21/11/2024.
//

import DLEntities
import Foundation

public protocol PPhotoDetailsFetchingUseCase {
	func loadPhoto (url: URL) async throws -> Data
}

