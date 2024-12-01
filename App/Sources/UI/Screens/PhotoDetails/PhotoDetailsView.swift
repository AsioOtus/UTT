//
//  PhotoDetailsView.swift
//  il-screen-photo-details
//
//  Created by Anton on 21/11/2024.
//

import Kingfisher
import SwiftUI

public struct PhotoDetailsView: View {
	@StateObject private var vm: PhotoDetailsVM<PhotoDetailsInteractor>

	public init (photoId: Int) {
		self._vm = .init(wrappedValue: .init(interactor: .init(photoId: photoId)))
	}

	public var body: some View {
		contentView()
			.onAppear(perform: vm.onAppear)
	}
}

private extension PhotoDetailsView {
	@ViewBuilder
	func contentView () -> some View {
		switch vm.photoModel {
		case .initial:
			initialView()

		case .loading:
			loadingView()

		case .successful(let photoModel):
			successfulView(photoModel)

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
	func successfulView (_ photoModel: PhotoModel) -> some View {
		ScrollView {
			VStack(spacing: 32) {
				if vm.useLowQualityUrl {
					imageView(photoModel.largeUrl)
				} else {
					imageView(photoModel.originalUrl)
				}
				photoDetailsView(photoModel)
			}
			.padding()
		}
	}

	func failedView () -> some View {
		VStack {
			Text("Something went wrong")
			Button("Refresh", action: vm.reload)
				.buttonStyle(.bordered)
		}
	}

	@ViewBuilder
	func imageView (_ photoUrl: URL) -> some View {
		KFImage(photoUrl)
			.placeholder(loadingView)
			.onFailureImage(.init(systemName: "exclamationmark.octagon")?.withTintColor(.red))
			.onFailure { error in
				print(error)
				vm.onImageLoadingFailed()
			}
			.resizable()
			.aspectRatio(contentMode: .fit)
			.clipShape(RoundedRectangle(cornerRadius: 20))
	}

	func photoDetailsView (_ photoModel: PhotoModel) -> some View {
		VStack(spacing: 16) {
			photoDetailsRowView("Author", photoModel.photographer)
			photoDetailsRowView("Description", photoModel.description)
			photoDetailsRowView("Size", photoModel.size)
			photoDetailsRowView("Photo ID", photoModel.id.description)
			photoDetailsRowView("URL", photoModel.originalUrl.absoluteString)
		}
	}

	func photoDetailsRowView (_ name: String, _ value: String) -> some View {
		HStack(alignment: .top) {
			Text(name)
				.bold()

			Spacer()

			Text(value)
				.multilineTextAlignment(.trailing)
		}
		.foregroundStyle(.secondary)
	}
}
