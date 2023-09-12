//
//  MealListView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI
import NukeUI

struct MealListView: View {
    @StateObject
    var viewModel: MealListViewModel = MealListViewModel()
    let girdItem = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
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
            .onAppear(perform: {
                viewModel.get(meals: "Dessert")
            })
            .toolbarRole(.navigationStack)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "list.bullet.indent")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .onTapGesture {
                            viewModel.sort()
                        }
                }
            })
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Constants.MealsViewTitle.rawValue)
    }
    
    var content: some View {
        ScrollView {
            if let _ = viewModel.state?.meals?.meals {
                recipeGrid.padding(.horizontal,15)
            }
        }
    }
    
    var recipeGrid: some View {
        LazyVGrid(columns: girdItem, spacing: 15) {
            ForEach(0 ..< (viewModel.state?.meals?.meals?.count ?? 0), id: \.self) {
                item in
                if 
                   let meal = viewModel.state?.list,
                   let mealUrlStr = meal[item].strMealThumb,
                   let mealUrl = URL(string: mealUrlStr),
                   let mealName = meal[item].strMeal {
                    imageContainer(meal: mealName, mealLink: mealUrl)
                        .onTapGesture {
                            viewModel.redirectTo(
                                meal: meal[item].idMeal ?? ""
                            )
                        }
                }
            }
        }
    }
    
    func imageContainer(meal name: String, mealLink url: URL) -> some View {
        ZStack {
            image(withLink: url)
            gradientContainer(meal: name)
        }
    }
    
    func gradientContainer(meal name: String) -> some View {
        ZStack(alignment: .bottom) {
            gradient
                .frame(height: 170)
                .cornerRadius(20,antialiased: true)
            VStack {
                HStack {
                    Text(name)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        .padding(.leading,10)
                        .lineLimit(0)
                    Spacer()
                }
                Spacer().frame(height:15)
            }
        }
    }
    
    func image(withLink url: URL) -> some View {
        LazyImage(request: ImageRequest(url: url)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .frame(height: 170)
                    .cornerRadius(
                        20,
                        antialiased: true
                    )
            }
        }
            
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
