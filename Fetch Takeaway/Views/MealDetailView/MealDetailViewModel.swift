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
            self.extractIngredients()
            self.extractMeasures()
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
    
    private func extractMeasures() {
        if let measure = self.state.mealDetail?.strMeasure1, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure2, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure3, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure4, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure5, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure6, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure7, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure8, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure9, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure10, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure11, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure12, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure13, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure14, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure15, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure16, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure17, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure18, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure19, measure != "" {
            state.measure += measure + " ,"
        }
        if let measure = self.state.mealDetail?.strMeasure20, measure != "" {
            state.measure += measure + " ,"
        }
        
    }
    
    private func extractIngredients() {
        if let ingredient1 = self.state.mealDetail?.strIngredient1, ingredient1 != "" {
            state.ingredients += ingredient1 + " ,"
        }
        if let ingredient2 = self.state.mealDetail?.strIngredient2, ingredient2 != "" {
            state.ingredients += ingredient2 + " ,"
        }
        if let ingredient3 = self.state.mealDetail?.strIngredient3 , ingredient3 != ""{
            state.ingredients += ingredient3 + " ,"
        }
        if let ingredient4 = self.state.mealDetail?.strIngredient4, ingredient4 != "" {
            state.ingredients += ingredient4 + " ,"
        }
        if let ingredient5 = self.state.mealDetail?.strIngredient5, ingredient5 != "" {
            state.ingredients += ingredient5 + " ,"
        }
        if let ingredient6 = self.state.mealDetail?.strIngredient6, ingredient6 != "" {
            state.ingredients += ingredient6 + " ,"
        }
        if let ingredient7 = self.state.mealDetail?.strIngredient7, ingredient7 != "" {
            state.ingredients += ingredient7 + " ,"
        }
        if let ingredient8 = self.state.mealDetail?.strIngredient8, ingredient8 != "" {
            state.ingredients += ingredient8 + ", "
        }
        if let ingredient9 = self.state.mealDetail?.strIngredient9, ingredient9 != "" {
            state.ingredients += ingredient9 + ", "
        }
        if let ingredient10 = self.state.mealDetail?.strIngredient10, ingredient10 != "" {
            state.ingredients += ingredient10 + ", "
        }
        if let ingredient11 = self.state.mealDetail?.strIngredient11, ingredient11 != "" {
            state.ingredients += ingredient11 + ", "
        }
        if let ingredient12 = self.state.mealDetail?.strIngredient12, ingredient12 != "" {
            state.ingredients += ingredient12 + ", "
        }
        if let ingredient13 = self.state.mealDetail?.strIngredient13, ingredient13 != "" {
            state.ingredients += ingredient13 + ", "
        }
        if let ingredient14 = self.state.mealDetail?.strIngredient14, ingredient14 != "" {
            state.ingredients += ingredient14 + ", "
        }
        if let ingredient15 = self.state.mealDetail?.strIngredient15, ingredient15 != "" {
            state.ingredients += ingredient15 + ", "
        }
        if let ingredient16 = self.state.mealDetail?.strIngredient16, ingredient16 != "" {
            state.ingredients += ingredient16 + ", "
        }
        if let ingredient17 = self.state.mealDetail?.strIngredient17, ingredient17 != "" {
            state.ingredients += ingredient17 + ", "
        }
        if let ingredient18 = self.state.mealDetail?.strIngredient18, ingredient18 != "" {
            state.ingredients += ingredient18 + ", "
        }
        if let ingredient19 = self.state.mealDetail?.strIngredient19, ingredient19 != "" {
            state.ingredients += ingredient19 + ", "
        }
        if let ingredient20 = self.state.mealDetail?.strIngredient20, ingredient20 != "" {
            state.ingredients += ingredient20 + ", "
        }
    }
}

// MARK: - MealDetailViewModel's methods exposed to view for consumption
extension MealDetailViewModel {
    func fetchMealDetail() async throws {
        try await _fetchMealDetail()
    }
}

