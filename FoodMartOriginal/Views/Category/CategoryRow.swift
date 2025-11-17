//
//  CategoryRow.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-16.
//

import SwiftUI

struct CategoryRow: View {
    @Binding var category: Category
    
    var body: some View {
        Toggle(isOn: $category.isEnabled) {
            Text(category.name)
        }
    }
}

#Preview {
    @Previewable @State var category = Category.example
    
    CategoryRow(category: $category)
        .padding()
}
