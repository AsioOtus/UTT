//
//  TestTaskFactory.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

import Foundation

// Based on: https://github.com/tinkoff-mobile-tech/TinkoffConcurrency

public final class TestTaskFactory: @unchecked Sendable {
	private let lock = NSLock()
	private var tasks: [PTask] = []

	public init () { }

	public func waitAll () async {
		while let task = popTask() {
			await task.wait()
		}
	}

	private func addTask (_ task: PTask) {
		lock.withLock {
			tasks.append(task)
		}
	}

	private func popTask () -> PTask? {
		lock.withLock {
			tasks.popLast()
		}
	}
}

extension TestTaskFactory: PTaskFactory {
	@discardableResult
	public func task<T: Sendable>(
		priority: TaskPriority?,
		@_inheritActorContext operation: @escaping @Sendable () async throws -> T
	) -> Task<T, Error> {
		let task = Task(priority: priority, operation: operation)

		addTask(task)

		return task
	}

	public func task<T: Sendable>(
		priority: TaskPriority?,
		@_inheritActorContext operation: @escaping @Sendable () async -> T
	) -> Task<T, Never> {
		let task = Task(priority: priority, operation: operation)

		addTask(task)

		return task
	}

	@discardableResult
	public func detached<T: Sendable>(
		priority: TaskPriority?,
		operation: @escaping @Sendable () async throws -> T
	) -> Task<T, Error> {
		let task = Task.detached(priority: priority, operation: operation)

		addTask(task)

		return task
	}

	public func detached<T: Sendable>(
		priority: TaskPriority?,
		operation: @escaping @Sendable () async -> T
	) -> Task<T, Never> {
		let task = Task.detached(priority: priority, operation: operation)

		addTask(task)

		return task
	}
}
