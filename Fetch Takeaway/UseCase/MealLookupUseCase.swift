//
//  MealLookupUseCase.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
/// UseCase to consume lookup api

enum DetailResult {
    case Success(result: MealDetailInfo)
    case Failure
}

class MealLookupUseCase: ObservableObject {
    /// Use this method to fetch meal details
    /// - Parameter detail: Identifier for meal
    static func get(detail forMeal: String) async throws -> DetailResult {
        let result: MealDetailInfo = try await HttpApiService.shared.perform(get: .details(forMeal))
        if let details = result.meals {
            return .Success(result: result)
        } else {
            return .Failure
        }
    }
}
