//
//  PhotoDetailsView.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import SwiftUI

public struct PhotoDetailsView: View {
	@StateObject private var vm: PhotoDetailsVM<PhotoDetailsInteractor>

	public init (url: URL) {
		self._vm = .init(wrappedValue: .init(interactor: .init(url: url)))
	}

	public var body: some View {
		contentView()
			.onAppear(perform: vm.onAppear)
	}
}

private extension PhotoDetailsView {
	@ViewBuilder
	func contentView () -> some View {
		switch vm.photo {
		case .initial:
			initialView()

		case .loading:
			loadingView()

		case .successful(let data):
			successfulView(data)

		case .failed:
			failedView()
		}
	}

	func initialView () -> some View {
		ProgressView()
	}

	func loadingView () -> some View {
		ProgressView()
	}

	@ViewBuilder
	func successfulView (_ data: Data) -> some View {
		if let image = UIImage(data: data) {
			imageView(image)
		} else {
			failedView()
		}
	}

	func failedView () -> some View {
		VStack {
			Text("Something went wrong")
			Button("Refresh", action: vm.reload)
				.buttonStyle(.bordered)
		}
	}

	func imageView (_ image: UIImage) -> some View {
		Image(uiImage: image)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.clipShape(RoundedRectangle(cornerRadius: 20))
			.padding()
	}
}
