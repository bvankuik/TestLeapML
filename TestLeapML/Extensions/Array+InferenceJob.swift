//
//  Array+InferenceJob.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/02/2023.
//

import Foundation

extension Array where Element == InferenceJob {
    func sortedNewestFirst() -> Self {
        self.sorted(by: {
            $0.createdAt > $1.createdAt
        })
    }
}
