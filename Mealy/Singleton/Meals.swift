//
//  Meals.swift
//  Mealy
//
//  Created by Danny Dong on 5/4/22.
//

import Foundation

class Meals {
    static let meals = Meals()
    
    var allMeals: [String: MealSummary] = [:]
    var currentIngredientList: [Ingredient] = []
    var analyzedIngredientList: [String: NutritionAnalysis] = [:]
    var chosenMeal: String?
    
    private init() {}
}


struct Ingredient: Codable {
    let name: String
    let portion: String
}
