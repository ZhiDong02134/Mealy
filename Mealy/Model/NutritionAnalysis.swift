//
//  NutritionAnalysis.swift
//  Mealy
//
//  Created by Danny Dong on 5/1/22.
//

import Foundation

struct NutritionAnalysis: Codable {
    let totalNutrients: Nutrients
}

struct Nutrients: Codable {
    let CA: SymbolDetails
    let CHOCDF: SymbolDetails
    let ENERC_KCAL: SymbolDetails
    let FAT: SymbolDetails
    let CHOLE: SymbolDetails
    let NA: SymbolDetails
    let PROCNT: SymbolDetails
    let SUGAR: SymbolDetails?
    
    var protein: Double {
        roundToTwoDecimalPlaces(PROCNT.quantity)
    }
    
    var sodium: Double {
        roundToTwoDecimalPlaces(NA.quantity)
    }
    
    var fat: Double {
        roundToTwoDecimalPlaces(FAT.quantity)
    }
    var cholesterol: Double {
        roundToTwoDecimalPlaces(CHOLE.quantity)
    }
    var calories: Double {
        roundToTwoDecimalPlaces(ENERC_KCAL.quantity)
    }
    
    var calcium: Double {
        roundToTwoDecimalPlaces(CA.quantity)
    }
    
    var carbs: Double {
        var totalCarb = 0.0
        if let sugarAmount = SUGAR?.quantity {
            totalCarb += sugarAmount
        }
        totalCarb += round(CHOCDF.quantity * 100) / 100.0
        return roundToTwoDecimalPlaces(totalCarb)
    }
    
    func roundToTwoDecimalPlaces(_ amount: Double) -> Double {
        return round(amount * 100) / 100.0
    }
}

struct SymbolDetails: Codable {
    let label: String
    let quantity: Double
    let unit: String
    
}

struct PostBody: Codable {
    let ingr: [String]
}
