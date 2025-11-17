//
//  URLSessionMock.swift
//  FoodMartOriginalTests
//
//  Created by Omar Chaudhry on 2025-11-16.
//

@testable import FoodMartOriginal
import Foundation

struct URLSessionMock: DataFetching {
    var responses: [String: Data] = [:]
    
    init(responses: [String: Data]) {
        self.responses = responses
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        let data = responses[url.absoluteString] ?? Data()
        return (data, URLResponse())
    }
}
