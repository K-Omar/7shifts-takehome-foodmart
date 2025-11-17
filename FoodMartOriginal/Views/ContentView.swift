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
            Group {
                switch foodViewModel.loadState {
                case .failed:
                    LoadFailedView(
                        error: foodViewModel.loadError,
                        retry: foodViewModel.loadAppData
                    )
                    
                default:
                    if hasNoData {
                        ProgressView()
                            .controlSize(.extraLarge)
                    } else {
                        FoodItemListView()
                            .sheet(isPresented: $isShowingCategoryFilters) {
                                CategoryFilterListView()
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
                            .toolbar {
                                categoryFilterButton
                            }
                    }
                }
            }
            .navigationTitle("Food")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .task(foodViewModel.loadAppData)
    }
    
    var categoryFilterButton: some View {
        Button {
            isShowingCategoryFilters = true
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
    
    var hasNoData: Bool {
        foodViewModel.categories.isEmpty || foodViewModel.foods.isEmpty
    }
}

#Preview {
    ContentView()
        .environmentObject(FoodViewModel())
}
