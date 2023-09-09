//
//  MealsList.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
/// Model representation of filter api
struct Meals: Decodable {
    let meals: [MealList]?
}
struct MealList: Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
