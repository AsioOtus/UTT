//
//  PhotoDetailFactory.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

struct PhotoDetailFactory {
	static let `default` = Self()

	func produce (photoId: Int) -> PhotoDetailsVM<PhotoDetailsInteractor> {
		.init(
			interactor: .init(
				photoId: photoId,
				photoDetailsFetchingUseCase: PhotoDetailsFetchingUseCase(
					photoDetailsDataProvider: PhotoDetailsRepository(),
					photoDetailsPersistentDataProvider: PhotoPersistentRepository()
				)
			)
		)
	}
}
