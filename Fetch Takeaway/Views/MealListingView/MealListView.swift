//
//  MealListView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI

struct MealListView: View {
    @StateObject
    var viewModel: MealListViewModel = MealListViewModel()
    var body: some View {
        content
            .onAppear(perform: {
                viewModel.get(meals: "Dessert")
            })
            .toolbarRole(.navigationStack)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Constants.MealsViewTitle.rawValue)
    }
    
    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
    }
    
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
