//
//  FeedFactory.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

struct FeedFactory {
	static let `default` = Self()

	func produce () -> FeedVM {
		.init(
			interactor: FeedInteractor(
				feedFetchingUseCase: FeedFetchingUseCase(
					feedDataProvider: FeedRepository(),
					photoDetailsPersistentDataProvider: PhotoPersistentRepository()
				)
			)
		)
	}
}

