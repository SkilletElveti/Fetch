//
//  MealDetailView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import SwiftUI
import YouTubePlayerKit
import NukeUI
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
            ScrollView {
                mealImage(image: detail.strMealThumb)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func mealImage(image: String?) -> some View {
        if let image,
           let url = URL(string: image)
        {
            LazyImage(request: ImageRequest(url: url)) { state in
                if let image = state.image {
                   image
                        .resizable()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height * 0.45
                        )
                }
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
