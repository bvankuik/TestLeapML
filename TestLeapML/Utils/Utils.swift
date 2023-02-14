//
//  Utils.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

struct Utils {
    static func loadModel<T: Decodable>(_ type: T.Type, from jsonResource: String) -> T {
        let url = Bundle.main.url(forResource: jsonResource, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let model = try! JSONDecoder().decode(T.self, from: data)
        return model
    }

}
