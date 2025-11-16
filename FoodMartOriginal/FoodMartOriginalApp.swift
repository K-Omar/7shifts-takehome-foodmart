//
//  FoodMartOriginalApp.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-12.
//

import SwiftUI

@main
struct FoodMartOriginalApp: App {
    @StateObject private var foodViewModel = FoodViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(foodViewModel)
        }
    }
}
