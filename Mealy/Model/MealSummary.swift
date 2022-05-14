//
//  MealSummary.swift
//  Mealy
//
//  Created by Danny Dong on 5/6/22.
//

import Foundation

protocol AddMeal {
    func addMeal(_ mealName: String, _ mealSummary: MealSummary)
}

struct MealSummary: Codable {
    var calories = 0.0
    var carbs  = 0.0
    var protein = 0.0
    var cholesterol = 0.0
    var calcium = 0.0
    var fat = 0.0
    var sodium = 0.0
}

struct MealHandler: AddMeal {

    var delegate: AddMeal?
    
    func addMeal(_ mealName: String, _ mealSummary: MealSummary) {
        delegate?.addMeal(mealName, mealSummary)
    }
}
