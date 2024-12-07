//
//  Loadable.swift
//  App
//
//  Created by Anton on 02/12/2024.
//

public enum Loadable <Value> {
	public typealias LoadingTask = Task<Void, Error>

	case initial
	case loading(task: LoadingTask?, value: Value?)
	case successful(Value)
	case failed(error: Error, value: Value?)

	init (asyncCatching: () async throws -> Value) async {
		do {
			self = try await .successful(asyncCatching())
		} catch {
			self = .failed(error: error, value: nil)
		}
	}
}

public extension Loadable {
	var debugName: String {
		switch self {
		case .initial:    "initial"
		case .loading:    "loading"
		case .successful: "successful"
		case .failed:     "failed"
		}
	}

	var successfulValue: Value? { if case .successful(let value) = self { value } else { nil } }

	var isLoading:    Bool { if case .loading    = self { true } else { false } }
	var isFailed:     Bool { if case .failed     = self { true } else { false } }

	var value: Value? {
		switch self {
		case .initial: nil
		case .loading(_, let value): value
		case .successful(let successful): successful
		case .failed(_, let value): value
		}
	}

	func mapValue <NewValue> (
		_ mapping: (Value) -> NewValue
	) -> Loadable<NewValue> {
		switch self {
		case .initial:                               .initial
		case .loading(let task, let value):  .loading(task: task, value: value.map(mapping))
		case .successful(let value):                 .successful(mapping(value))
		case .failed(let error, let value):  .failed(error: error, value: value.map(mapping))
		}
	}

	var loadingTask: LoadingTask? { if case .loading(let task, _) = self { task } else { nil } }

	func cancel () {
		loadingTask?.cancel()
	}
}

extension Loadable: Equatable where Value: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		switch (lhs, rhs) {
		case (.initial, .initial): true
		case (.loading(let lTask, let lValue), .loading(let rTask, let rValue)): lTask == rTask && lValue == rValue
		case (.successful(let lValue), .successful(let rValue)): lValue == rValue
		case (.failed(let lError, let lValue), .failed(let rError, let rValue)): type(of: lError) == type(of: rError) && lValue == rValue
		default: false
		}
	}
}
