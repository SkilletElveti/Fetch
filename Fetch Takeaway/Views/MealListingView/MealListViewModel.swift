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
        if state?.meals == nil {
            Task.detached {@MainActor [weak self] in
                guard let self else { return }
                self.state?.meals = Meals(meals: try await MealsRepository.shared.get(meals: identifier))
            }
        }
    }
}

// MARK: - Methods exposed to view for consumption
extension MealListViewModel {
    func get(meals identifier: String) {
        Task {
            do {
                try await self._get(meals: identifier)
            } catch {
                GeneralisedLogger.log(error: "Error in getting meals for: \(identifier)")
            }
        }
        
    }
}
