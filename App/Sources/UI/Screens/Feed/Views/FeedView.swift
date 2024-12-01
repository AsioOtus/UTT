//
//  FeedView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import SwiftUI

public struct FeedView: View {
	@State private var presentedPhotoId: Int?

	public init () { }

	private var isPresentedPhotoIdActive: Binding<Bool> {
		.init(
			get: {
				presentedPhotoId != nil
			},
			set: {
				if !$0 {
					presentedPhotoId = nil
				}
			}
		)
	}

	public var body: some View {
		NavigationStack {
			FeedViewControllerRepresentable(presentedPhotoId: $presentedPhotoId)
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("Curated photos")
				.ignoresSafeArea()
				.navigationDestination(isPresented: isPresentedPhotoIdActive) {
					if let photoId = presentedPhotoId {
						PhotoDetailsView(photoId: photoId)
					}
				}
				.toolbar {
					ToolbarItem(placement: .topBarTrailing) {
						CacheCleanupMenuView()
					}
				}
		}
	}
}
