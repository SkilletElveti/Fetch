//
//  MealsRepository.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
/// Source of meals. Can be used gloablly within the app to fetch meals. Scope does not include Paginated request, else we can add mechanisms to append data.
class MealsRepository: ObservableObject {
    static let shared = MealsRepository()
    private var meals: [String: [MealList]] = [:]
    func get(meals identifier: String) async throws -> [MealList] {
        guard meals[identifier] == nil else { return meals[identifier, default: []] }
        switch try await MealsUseCase.get(mealName: identifier) {
        case .Success(let result):
            meals[identifier, default: []] = result.meals ?? []
            return result.meals ?? []
        case .Failure:
            return []
        }
    }
}
