//
//  RootView.swift
//  il-screen-root
//
//  Created by Anton on 20/11/2024.
//

import ILScreenFeed
import SwiftUI

public struct RootView: View {
	public init () { }

	public var body: some View {
		FeedView()
			.tint(.cyan)
	}
}
