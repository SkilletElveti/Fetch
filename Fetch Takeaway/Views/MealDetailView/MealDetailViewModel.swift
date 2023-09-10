//
//  MealDetailViewModel.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation

// MARK: - MealDetailState
struct MealDetailState {
    var mealId: String?
}

// MARK: - MealDetailViewModel implementation
class MealDetailViewModel: ObservableObject {
    @Published
    var state = MealDetailState()
    init(mealID identifier: String) {
        self.state.mealId = identifier
    }
    
    func _fetchMealDetail() {
        guard let identifier = state.mealId else { return }
    }
}

// MARK: - MealDetailViewModel's methods exposed to view for consumption
extension MealDetailViewModel {
    
}
