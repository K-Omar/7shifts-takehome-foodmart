//
//  LoadFailedView.swift
//  FoodMartOriginal
//
//  Created by Omar Chaudhry on 2025-11-16.
//

import SwiftUI

struct LoadFailedView: View {
    var error: (any Error)?
    var retry: () async -> Void
    var body: some View {
        ContentUnavailableView {
            Text("Oops...")
                .font(.largeTitle)
                .padding()
        } description: {
            Text("Something went wrong.")
        } actions: {
            Button("Retry") {
                Task {
                    await retry()
                }
            }
        }
    }
}

#Preview {
    LoadFailedView(error: NSError(domain: "7shifts-TakeHome", code: 1)) {
        // do nothing
    }
}
