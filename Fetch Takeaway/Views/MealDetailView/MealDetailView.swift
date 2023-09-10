//
//  MealDetailView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject
    var viewModel: MealDetailViewModel
    var body: some View {
        Text("Meal Detail id: \(viewModel.state.mealId ?? "0")")
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
