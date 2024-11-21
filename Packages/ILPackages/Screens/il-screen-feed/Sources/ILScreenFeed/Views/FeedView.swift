//
//  FeedView.swift
//  il-screen-feed
//
//  Created by Anton on 21/11/2024.
//

import ILComponents
import ILScreenPhotoDetails
import SwiftUI

public struct FeedView: View {
	@State private var presentedPhotoUrl: URL?

	public init () { }

	private var isPresentedPhotoUrlActive: Binding<Bool> {
		.init(
			get: {
				presentedPhotoUrl != nil
			},
			set: {
				if !$0 {
					presentedPhotoUrl = nil
				}
			}
		)
	}

	public var body: some View {
		NavigationStack {
			FeedViewControllerRepresentable(presentedPhotoUrl: $presentedPhotoUrl)
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("Curated photos")
				.ignoresSafeArea()
				.navigationDestination(isPresented: isPresentedPhotoUrlActive) {
					if let url = presentedPhotoUrl {
						PhotoDetailsView(url: url)
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
