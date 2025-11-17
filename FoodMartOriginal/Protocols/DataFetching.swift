//
//  DataFetching.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-16.
//

import Foundation

protocol DataFetching: Sendable {
    func data(from: URL) async throws -> (Data, URLResponse)
}

extension URLSession: DataFetching { }
