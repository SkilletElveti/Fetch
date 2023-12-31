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
    var ingredients: String = ""
    var measure: String = ""
    var ingrdients: [MealExtracted] = []
}

// MARK: - MealDetailViewModel implementation
class MealDetailViewModel: ObservableObject {
    @Published
    var state = MealDetailState()
    private var mealIngredient: [MealExtracted] = []
    init(mealID identifier: String) {
        self.state.mealId = identifier
    }
    
    func _fetchMealDetail() async throws {
        guard let identifier = state.mealId else { return }
        Task.detached { @MainActor [weak self] in
            guard let self else { return }
            self.state.mealDetail = try await MealLookupRepository.shared.get(details: identifier)
            self.getIngredients()
        }
    }
    
    private func getIngredients() {
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient1, measure: self.state.mealDetail?.strMeasure1))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient2, measure: self.state.mealDetail?.strMeasure2))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient3, measure: self.state.mealDetail?.strMeasure3))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient4, measure: self.state.mealDetail?.strMeasure4))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient5, measure: self.state.mealDetail?.strMeasure5))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient6, measure: self.state.mealDetail?.strMeasure6))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient7, measure: self.state.mealDetail?.strMeasure7))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient8, measure: self.state.mealDetail?.strMeasure8))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient9, measure: self.state.mealDetail?.strMeasure9))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient10, measure: self.state.mealDetail?.strMeasure10))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient11, measure: self.state.mealDetail?.strMeasure11))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient12, measure: self.state.mealDetail?.strMeasure12))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient13, measure: self.state.mealDetail?.strMeasure13))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient14, measure: self.state.mealDetail?.strMeasure14))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient15, measure: self.state.mealDetail?.strMeasure15))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient16, measure: self.state.mealDetail?.strMeasure16))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient17, measure: self.state.mealDetail?.strMeasure17))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient18, measure: self.state.mealDetail?.strMeasure18))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient19, measure: self.state.mealDetail?.strMeasure19))
        self.mealIngredient.append(MealExtracted(ingredient: self.state.mealDetail?.strIngredient20, measure: self.state.mealDetail?.strMeasure20))
        var ingredients: [MealExtracted] = []
        for i in 0 ..< mealIngredient.count {
            if mealIngredient[i].ingredient != "" && mealIngredient[i].measure != "" {
                ingredients.append(mealIngredient[i])
            }
        }
        state.ingrdients = ingredients
    }
    
}

// MARK: - MealDetailViewModel's methods exposed to view for consumption
extension MealDetailViewModel {
    func fetchMealDetail() async throws {
        try await _fetchMealDetail()
    }
}

