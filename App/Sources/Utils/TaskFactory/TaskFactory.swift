//
//  TaskFactor.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

import Foundation

// Based on: https://github.com/tinkoff-mobile-tech/TinkoffConcurrency

public struct TaskFactory: PTaskFactory {
	public init () { }

	public func task <T: Sendable> (
		priority: TaskPriority?,
		@_inheritActorContext operation: @escaping @Sendable () async throws -> T
	) -> Task<T, Error> {
		Task(priority: priority, operation: operation)
	}

	public func task <T: Sendable> (
		priority: TaskPriority?,
		@_inheritActorContext operation: @escaping @Sendable () async -> T
	) -> Task<T, Never> {
		Task(priority: priority, operation: operation)
	}

	public func detached <T: Sendable> (
		priority: TaskPriority?,
		operation: @escaping @Sendable () async throws -> T
	) -> Task<T, Error> {
		Task.detached(priority: priority, operation: operation)
	}

	public func detached <T: Sendable> (
		priority: TaskPriority?,
		operation: @escaping @Sendable () async -> T
	) -> Task<T, Never> {
		Task.detached(priority: priority, operation: operation)
	}
}