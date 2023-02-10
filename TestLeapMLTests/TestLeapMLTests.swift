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

    func testGenerateImageService() async throws {
        let inference = try await GenerateImageService.call()
        XCTAssert(!inference.id.isEmpty)
    }
    
    func testGenerateImageModel() {
        let url = Bundle(for: Self.self).url(forResource: "GenerateImage", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let inference = try! JSONDecoder().decode(Inference.self, from: data)
        XCTAssert(!inference.id.isEmpty)
        XCTAssert(inference.images.isEmpty)
        XCTAssert(!inference.modelID.isEmpty)
    }

    func testListInferenceModel() {
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
