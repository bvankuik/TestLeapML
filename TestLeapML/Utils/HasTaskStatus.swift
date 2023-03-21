//
//  HasTaskStatus.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/03/2023.
//

import LeapML

enum TaskStatus {
    case idle, loading, error(Error), success, canceling, exhausted

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
}

protocol HasTaskStatus {
    @MainActor var taskStatus: TaskStatus { get set }
}
