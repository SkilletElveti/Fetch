//
//  MealDetailLink.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
/// Data link used to redirect to the MealDetailView
/// - Parameter mealId: Meal id
/// - Parameter viewModel: MealDetailViewModel's instance
struct MealDetailLink: Hashable {
    static func == (lhs: MealDetailLink, rhs: MealDetailLink) -> Bool {
        lhs.mealId == rhs.mealId
    }
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    var mealId: String
    var viewModel: MealDetailViewModel
    init(mealId: String, viewModel: MealDetailViewModel) {
        self.mealId = mealId
        self.viewModel = viewModel
    }
}
