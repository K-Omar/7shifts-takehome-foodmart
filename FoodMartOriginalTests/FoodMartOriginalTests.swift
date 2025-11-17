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
    
    @Test func filteredFoodsWithNoCategoriesEnabled() async throws {
        let viewModel = try FoodViewModel(session: createMockURLSession())
        await viewModel.loadAppData()
        
        // Verify initial state - no categories enabled should show all foods
        let filtered = viewModel.filteredFoods
        #expect(filtered.count == viewModel.foods.count,
               "Should return all foods when no categories are enabled")
    }
    
    @Test func filteredFoodsWithSingleCategoryEnabled() async throws {
        let viewModel = try FoodViewModel(session: createMockURLSession())
        await viewModel.loadAppData()
        
        // Enable only Produce category
        if let categoryIndex = viewModel.categories.firstIndex(where: { $0.name == "Produce" }) {
            viewModel.categories[categoryIndex].isEnabled = true
            
            let filtered = viewModel.filteredFoods
            
            // Should have 2 items: Bananas and Apple
            #expect(filtered.count == 2, "Should return 2 foods from Produce category only")
            
            let foodNames = filtered.map { $0.name }
            #expect(foodNames.contains("Bananas"), "Should include Bananas")
            #expect(foodNames.contains("Apple"), "Should include Apple")
            #expect(!foodNames.contains("Chicken breast"), "Should exclude food from category that is not enabled")
        }
    }

    @Test func filteredFoodsWithMultipleCategoriesEnabled() async throws {
        let viewModel = try FoodViewModel(session: createMockURLSession())
        await viewModel.loadAppData()
        
        // Enable both Produce and Meat categories
        for categoryName in ["Produce", "Meat"] {
            if let categoryIndex = viewModel.categories.firstIndex(where: { $0.name == categoryName }) {
                viewModel.categories[categoryIndex].isEnabled = true
            }
        }
        
        let filtered = viewModel.filteredFoods
        let enabledCategoryUuids = viewModel.categories.filter { $0.isEnabled }.map { $0.uuid }
        
        let expectedFoods = viewModel.foods.filter { food in
            enabledCategoryUuids.contains(food.categoryUuid)
        }
        
        #expect(filtered.count == expectedFoods.count, "Should return foods from all enabled categories")
        
        // Verify each filtered food belongs to an enabled category
        for food in filtered {
            #expect(enabledCategoryUuids.contains(food.categoryUuid), "Each filtered food should belong to an enabled category")
        }
    }

    func createMockURLSession() throws -> URLSessionMock {
        // Sample foods
        let foods = [
            // Produce items
            Food(
                uuid: "a1f7b3e5-4c1d-42e9-8f2a-8cbb8b1f6f01",
                categoryUuid: "b1f6d8a5-0e29-4d70-8d4f-1f8c1d7a5b12",
                name: "Bananas",
                price: 1.49,
                imageUrl: "https://7shifts.github.io/mobile-takehome/images/bananas.png"
            ),
            Food(
                uuid: "e9f2c6d5-4b3e-41a7-8c4d-5e9f7a2b4a09",
                categoryUuid: "b1f6d8a5-0e29-4d70-8d4f-1f8c1d7a5b12",
                name: "Apple",
                price: 0.99,
                imageUrl: "https://7shifts.github.io/mobile-takehome/images/apple.png"
            ),
            
            // Dairy items
            Food(
                uuid: "d3f5e2b8-1a2c-4b5e-9d2c-0f3b4e2d7a03",
                categoryUuid: "d2b7e3f9-5c4b-4e50-9b7a-3b7e6f4c2d18",
                name: "Whole milk",
                price: 4.29,
                imageUrl: "https://7shifts.github.io/mobile-takehome/images/whole_milk.png"
            ),
            Food(
                uuid: "e4a6f1c9-7b3d-41e2-91f1-2c4b1e7d8a04",
                categoryUuid: "d2b7e3f9-5c4b-4e50-9b7a-3b7e6f4c2d18",
                name: "Cheddar cheese",
                price: 5.49,
                imageUrl: "https://7shifts.github.io/mobile-takehome/images/cheddar_cheese.png"
            ),
            
            // Meat items
            Food(
                uuid: "f5b7e2d1-3c4a-4e5f-8c2d-1b4e6d7a9a05",
                categoryUuid: "f3a6c4e2-1d4c-4a3c-8d3d-6b8c15f0e2b9",
                name: "Chicken breast",
                price: 11.99,
                imageUrl: "https://7shifts.github.io/mobile-takehome/images/chicken_breast.png"
            )
        ]
        
        // Sample categories
        let categories = [
            Category(uuid: "b1f6d8a5-0e29-4d70-8d4f-1f8c1d7a5b12", name: "Produce", isEnabled: false),
            Category(uuid: "f3a6c4e2-1d4c-4a3c-8d3d-6b8c15f0e2b9", name: "Meat", isEnabled: false),
            Category(uuid: "d2b7e3f9-5c4b-4e50-9b7a-3b7e6f4c2d18", name: "Dairy", isEnabled: false),
            Category(uuid: "e0d8a1f6-7b2c-4e2c-91f1-9b8f7e3d5a10", name: "Bakery", isEnabled: false),
            Category(uuid: "a9c4f1e0-3b2d-4d6a-8c5e-0b4f1b6d9a23", name: "Frozen", isEnabled: false),
            Category(uuid: "c2f3d7e1-8b1a-4c5e-9d2f-6f0b3e2d8a45", name: "Pantry", isEnabled: false)
        ]
        
        let foodsData = try JSONEncoder().encode(foods)
        let categoriesData = try JSONEncoder().encode(categories)
        
        return URLSessionMock(responses: [
            "https://7shifts.github.io/mobile-takehome/api/food_items.json": foodsData,
            "https://7shifts.github.io/mobile-takehome/api/food_item_categories.json": categoriesData
        ])
    }

}
