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

// MARK: - MealListViewModel Implementation
class MealListViewModel: ObservableObject {
    @Published
    var state: MealState?
    init() {
        state = MealState()
    }
    
    func _get(meals identifier: String) async throws {
        if state?.meals == nil {
            Task.detached {
                @MainActor [weak self] in
                guard let self else { return }
                self.state?.meals = Meals(meals: try await MealsRepository.shared.get(meals: identifier))
            }
        }
    }
    
    func _redirectTo(meal identifier: String) async throws {
        NavigationStackService.shared.navigation(
            push: MealDetailLink(mealId: identifier, viewModel: MealDetailViewModel(mealID: identifier))
        )
        GeneralisedLogger.log(
            message: "Redirecting to meal details: \(identifier)", filter: "MealListViewModel"
        )
    }
}

// MARK: - Methods exposed to view for consumption
extension MealListViewModel {
    func get(meals identifier: String) {
        Task {
            do {
                try await self._get(meals: identifier)
            } catch {
                GeneralisedLogger.log(error: "Error in getting meals for: \(identifier)", filter: "MealListViewModel")
            }
        }
    }
    
    func redirectTo(meal identifier: String) {
        Task {
            do {
                try await _redirectTo(meal: identifier)
            } catch {
                GeneralisedLogger.log(error: "Error in getting meal details for: \(identifier)", filter: "MealListViewModel")

            }
        }
    }
}
