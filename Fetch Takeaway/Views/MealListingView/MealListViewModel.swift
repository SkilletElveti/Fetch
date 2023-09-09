//
//  MealListViewModel.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
/// ViewModel for MealListView
struct MealState {
    var meals: Meals?
}

class MealListViewModel: ObservableObject {
    @Published
    var state: MealState?
    init() {
        state = MealState()
    }
    
    func _get(meals identifier: String) async throws {
        try await MealsRepository
    }
}

// MARK: - Methods exposed to view for consumption
extension MealListViewModel {
    func get(meals identifier: String) {
        Task {
            do {
                try await self._get(meals: identifier)
            } catch {
                
            }
        }
        
    }
}
