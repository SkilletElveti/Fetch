//
//  MealsUseCase.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation

enum MealResult {
    case Success(result: Meals)
    case Failure
}
/// To consume filter API, use this UseCase.
class MealsUseCase {
    /// Get list meal response from the meal db server
    /// - Parameter mealName : Specify meal name to get list of meals
    static func get(mealName identifier: String) async throws -> MealResult {
        let result: Meals = try await HttpApiService.shared.perform(get: .meals(identifier))
        if result.meals?.count ?? 0 > 0 {
            return .Success(result: result)
        } else {
            return .Failure
        }
    }
}
