//
//  CategoryFilterListView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-15.
//

import SwiftUI

struct CategoryFilterListView: View {
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    var body: some View {
        List($foodViewModel.categories, rowContent: CategoryRow.init)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
    }
}

#Preview {
    @Previewable @StateObject var viewModel = FoodViewModel()
    
    CategoryFilterListView()
        .environmentObject(viewModel)
        .task(viewModel.loadAppData)
}
