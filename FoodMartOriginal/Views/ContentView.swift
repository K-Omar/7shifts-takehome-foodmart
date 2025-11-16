//
//  ContentView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    @State private var isShowingCategoryFilters = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
              FoodItemListView()
            }
            .sheet(isPresented: $isShowingCategoryFilters) {
               CategoryFilterListView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    categoryFilterButton
                }
            }
            .navigationTitle("Food")
            .toolbarTitleDisplayMode(.inlineLarge)
            .task {
                await foodViewModel.loadFoods()
                await foodViewModel.loadCategories()
            }
        }
    }
    
    var categoryFilterButton: some View {
        Button {
            isShowingCategoryFilters = true
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FoodViewModel())
}
