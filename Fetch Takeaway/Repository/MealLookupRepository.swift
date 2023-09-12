//
//  MealLookupRepository.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
class MealLookupRepository: ObservableObject {
    static let shared = MealLookupRepository()
    private var recipe: [String: MealDetails] = [:]
    func get(details forMeal: String) async throws -> MealDetails? {
        if let recipe = recipe[forMeal] { return recipe }
        let result = try await MealLookupUseCase.get(detail: forMeal)
        switch result {
        case .Success(let result):
            recipe[forMeal] = result.meals?.first
            return result.meals?.first
        case .Failure:
            return nil
        }
    }
}
