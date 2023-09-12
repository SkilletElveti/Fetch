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
            .toolbarRole(.editor)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack {
                        youtubeLink
                        Spacer()
                            
                        sourceLink
                    }
                })
            })
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
                ingredientsTable()
                instructions(text: detail.strInstructions)
                Spacer()
            }
        }
    }
}

//MARK: - Instruction View
extension MealDetailView {
    @ViewBuilder
    func instructions(text: String?) -> some View {
        
        if let text {
            
            Text(text)
                .foregroundColor(.black)
                .padding([.top,.bottom,.leading], 12)
        }
    }
}

//MARK: - Ingredients
extension MealDetailView {
   
    func ingredientsTable() -> some View {
            VStack {
                HStack {
                    Text("Ingredients:")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom,4)
                    Spacer()
                }
                
                ForEach(viewModel.state.ingrdients , id: \.self) { meal in
                HStack {
                    HStack {
                        Text(meal.ingredient ?? "")
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text(meal.measure ?? "")
                        Spacer()
                    }
                    
                }
            }
            }.padding([.top,.bottom,.leading],12)
    }
    
    func ingredientsView(meal: MealDetails) -> some View {
        VStack {
            HStack {
                Text("Ingrdients:")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.bottom,4)
            unwrapped(str: viewModel.state.ingredients)
        }.padding(.all,12)
    }
    
    @ViewBuilder
    func unwrapped(str: String?) -> some View {
        if let str {
            HStack {
                Text(str)
                Spacer()
            }
        }
    }
}

//MARK: - Measure View
extension MealDetailView {
    @ViewBuilder
    var sourceLink: some View {
        if let source = viewModel.state.mealDetail?.strSource,
        let url = URL(string: source) {
            Link(destination: url) {
                Image(systemName: "link")
                    .font(.system(size: 15))
                    .fontWidth(.standard)
            }
        }
    }
    
    @ViewBuilder
    var youtubeLink: some View {
        if let source = viewModel.state.mealDetail?.strYoutube,
        let url = URL(string: source) {
            Link(destination: url) {
                Image(systemName: "video.and.waveform")
                    .font(.system(size: 15))
                    .fontWidth(.standard)
            }
        }
    }
}


//MARK: - Header Views
extension MealDetailView {
    @ViewBuilder
    func headerRow(
        text: String,
        font: Font,
        weight: Font.Weight,
        useBottom: Bool = false,
        bottom: CGFloat = 5,
        useLeading: Bool = false,
        leading: CGFloat = 12,
        trailingSpacer: Bool = true
    ) -> some View {
        HStack {
            Text(text)
                .font(font)
                .fontWeight(weight)
                .padding(.bottom, useBottom ? bottom : 0)
                .padding(.leading, useLeading ? leading : 0)
                .foregroundColor(.white)
            if trailingSpacer {
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
                                headerRow(
                                    text: name,
                                    font: .largeTitle,
                                    weight: .medium,
                                    useLeading: true,
                                    leading: 10,
                                    trailingSpacer: true
                                )
                                
                                if let category {
                                    headerRow(
                                        text: category,
                                        font: .headline,
                                        weight: .medium,
                                        useBottom: true,
                                        bottom: 5,
                                        useLeading: true,
                                        leading: 10
                                    )
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
