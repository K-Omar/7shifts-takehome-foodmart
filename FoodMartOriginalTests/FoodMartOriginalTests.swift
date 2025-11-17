//
//  FoodMartOriginalTests.swift
//  FoodMartOriginalTests
//
//  Created by Omar Chaudhry on 2025-11-16.
//

@testable import FoodMartOriginal
import Foundation
import Testing

@MainActor
struct FoodMartOriginalTests {
    
    @Test func viewModelStartsEmpty() {
        let viewModel = FoodViewModel()
        
        #expect(viewModel.categories.isEmpty && viewModel.foods.isEmpty, "There should be no categories or foods initially")
    }
    
    @Test func viewModelLoadsAppData() async throws {
        let viewModel = try FoodViewModel(session: createMockURLSession())
        await viewModel.loadAppData()
        
        #expect(viewModel.categories.isEmpty == false && viewModel.foods.isEmpty == false, "There should be data after loading")
        #expect(viewModel.loadState == .loaded, "The view model should finish loading in a loaded state")
    }
    
    func createMockURLSession() throws -> URLSessionMock {
        let foods = [Food.example]
        let categories = [Category.example]
        
        let foodsData = try JSONEncoder().encode(foods)
        let categoriesData = try JSONEncoder().encode(categories)
        
        return URLSessionMock(responses: [
            "https://7shifts.github.io/mobile-takehome/api/food_items.json": foodsData,
            "https://7shifts.github.io/mobile-takehome/api/food_item_categories.json": categoriesData
        ])
    }

}
