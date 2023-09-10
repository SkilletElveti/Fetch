//
//  MealDetailView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import SwiftUI
import YouTubePlayerKit
struct MealDetailView: View {
    @EnvironmentObject
    var viewModel: MealDetailViewModel
    var body: some View {
        content
            .onAppear {
                Task {
                    try await viewModel.fetchMealDetail()
                }
            }
    }
    
    @ViewBuilder
    var content: some View {
        if let detail = viewModel.state.mealDetail {
            Text("Data Parsed")
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
