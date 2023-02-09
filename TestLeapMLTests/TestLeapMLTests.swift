//
//  TestLeapMLTests.swift
//  TestLeapMLTests
//
//  Created by Bart van Kuik on 08/02/2023.
//

import XCTest

final class TestLeapMLTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateImage() async throws {
        let inferences = try await GenerateImageService.call()
        XCTAssert(!inferences.isEmpty)
    }

    func testListInferenceModel() async throws {
        let url = Bundle(for: TestLeapMLTests.self).url(forResource: "ListInferenceJobs", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let jobs = try! JSONDecoder().decode([InferenceJob].self, from: data)
        XCTAssert(!jobs.isEmpty)
    }

    func testListInferenceService() async throws {
        let inferenceJobs = try await ListInferenceService.call()
        XCTAssert(!inferenceJobs.isEmpty)
    }
}
