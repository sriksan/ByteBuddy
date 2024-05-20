//
//  Meal.swift
//  ByteBuddy
//
//  Created by Justin Li on 4/3/24.
//

import Foundation


struct Meal: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let calories: Double?
    let fat: Double
    let carbs: Double
    let sugar: Double
    let protein: Double
    
    var formattedCalories: String {
        if let calories = calories {
            if calories.truncatingRemainder(dividingBy: 1.0) == 0.0 {
                return String(Int(calories))
            } else {
                return String(format: "%.2f", calories)
            }
        } else {
            return "N/A"
        }
    }
}
struct MealInfo: Decodable {
    let name: String
    let calories: Int
    let fat: Int
    let carbs: Int
    let sugar: Int
    let protein: Int
}

