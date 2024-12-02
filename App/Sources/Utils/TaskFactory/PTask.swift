//
//  Task.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

import Foundation

// Based on: https://github.com/tinkoff-mobile-tech/TinkoffConcurrency

protocol PTask {
	func wait () async
}

extension Task: PTask {
	func wait () async {
		_ = await self.result
	}
}
