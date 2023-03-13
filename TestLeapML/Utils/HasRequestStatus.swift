//
//  HasRequestStatus.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 07/03/2023.
//

import Foundation

enum RequestStatus {
    case idle, loading, success, error(Error)
}

protocol HasRequestStatus {
    @MainActor var requestStatus: RequestStatus { get set }
}
