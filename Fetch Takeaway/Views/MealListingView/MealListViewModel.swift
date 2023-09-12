//
//  MealListViewModel.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
import SwiftUI
/// ViewModel for MealListView
struct MealState {
    var meals: Meals?
    var list: [MealList] = []
}

// MARK: - MealListViewModel Implementation
class MealListViewModel: ObservableObject {
    @Published
    var state: MealState?
    init() {
        state = MealState()
    }
    private var sortFlag: Bool = false
    func _get(meals identifier: String) async throws {
        if state?.meals == nil {
            Task.detached {
                @MainActor [weak self] in
                guard let self else { return }
                self.state?.meals = Meals(meals: try await MealsRepository.shared.get(meals: identifier))
                self.state?.list = self.state?.meals?.meals ?? []
                self.state?.list.sort(by: {
                    $0.strMeal ?? "" < $1.strMeal ?? ""
                })
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
    
    private func _sort() {
        var list = state?.meals?.meals
        if sortFlag {
            list?.sort(by: {
                ($0.strMeal ?? "") < ($1.strMeal ?? "")
            })
        } else {
            list?.sort(by: {
                ($0.strMeal ?? "") > ($1.strMeal ?? "")
            })
        }
        sortFlag = !sortFlag
        withAnimation {
            state?.list = list ?? []
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
    
    func sort() {
        self._sort()
    }
}
