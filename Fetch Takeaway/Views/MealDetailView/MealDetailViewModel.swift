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
    var mealDetail: MealDetails?
}

// MARK: - MealDetailViewModel implementation
class MealDetailViewModel: ObservableObject {
    @Published
    var state = MealDetailState()
    init(mealID identifier: String) {
        self.state.mealId = identifier
    }
    
    func _fetchMealDetail() async throws {
        guard let identifier = state.mealId else { return }
        Task.detached { @MainActor [weak self] in
            guard let self else { return }
            self.state.mealDetail = try await MealLookupRepository.shared.get(details: identifier)
        }
    }
}

// MARK: - MealDetailViewModel's methods exposed to view for consumption
extension MealDetailViewModel {
    func fetchMealDetail() async throws {
        try await _fetchMealDetail()
    }
}
