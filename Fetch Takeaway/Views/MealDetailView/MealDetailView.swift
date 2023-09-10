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
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
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
                mealImage(
                    image: detail.strMealThumb,
                    name: detail.strMeal,
                    category: detail.strCategory
                )
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func mealImage(
        image: String?,
        name: String?,
        category: String?
    ) -> some View {
        if let image,
           let url = URL(string: image),
           let name = name
        {
            LazyImage(request: ImageRequest(url: url)) { state in
                if let image = state.image {
                    ZStack(alignment: .bottom) {
                        image
                             .resizable()
                             .frame(
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height * 0.45
                             )
                        ZStack(alignment: .bottom) {
                            gradient
                                .frame(height: category != nil ? 220 : 150)
                            VStack {
                                HStack {
                                    Text(name)
                                        .font(.largeTitle)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.leading,10)
                                    Spacer()
                                }
                                if let category {
                                    HStack {
                                        Text(category)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .padding(.leading,10)
                                            .padding(.bottom,5)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
                    }
                  
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
