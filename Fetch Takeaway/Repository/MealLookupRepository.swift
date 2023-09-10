//
//  MealLookupRepository.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
class MealLookupRepository: ObservableObject {
    static let shared = MealLookupRepository()
    func get(details forMeal: String) async throws -> MealDetails? {
        let result = try await MealLookupUseCase.get(detail: forMeal)
        switch result {
        case .Success(let result):
            return result.meals?.first
        case .Failure:
            return nil
        }
    }
}
