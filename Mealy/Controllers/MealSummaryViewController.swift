//
//  MealSummaryViewController.swift
//  Mealy
//
//  Created by Danny Dong on 5/7/22.
//

import UIKit

class MealSummaryViewController: UIViewController {

    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var calciumLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Meals.meals.chosenMeal == nil {
            self.dismiss(animated: true, completion: nil)
        }
        
        if let mealName = Meals.meals.chosenMeal {
            if let summary = Meals.meals.allMeals[mealName] {
                caloriesLabel.text = "\(summary.calories)kcal"
                carbsLabel.text = "\(summary.carbs)g"
                cholesterolLabel.text = "\(summary.cholesterol)mg"
                proteinLabel.text = "\(summary.protein)g"
                calciumLabel.text = "\(summary.calcium)mg"
                sodiumLabel.text = "\(summary.sodium)mg"
                fatLabel.text = "\(summary.fat)g"
            }
        }
    }
    
        //{
        //    totalNutrients =     {
        //        CA =         {
        //            label = "Calcium, Ca";
        //            quantity = "10.92";
        //            unit = mg;
        //        };
        //        CHOCDF =         {
        //            label = "Carbohydrate, by difference";
        //            quantity = "25.1342";
        //            unit = g;
        //        };
        //        CHOLE =         {
        //            label = Cholesterol;
        //            quantity = 0;
        //            unit = mg;
        //        };
        //        "ENERC_KCAL" =         {
        //            label = Energy;
        //            quantity = "94.64";
        //            unit = kcal;
        //        };
        //        FAT =         {
        //            label = "Total lipid (fat)";
        //            quantity = "0.3094";
        //            unit = g;
        //        };
        //        FE =         {
        //            label = "Iron, Fe";
        //            quantity = "0.2184";
        //            unit = mg;
        //        };
        //        FIBTG =         {
        //            label = "Fiber, total dietary";
        //            quantity = "4.368";
        //            unit = g;
        //        };
        //        NA =         {
        //            label = "Sodium, Na";
        //            quantity = "1.82";
        //            unit = mg;
        //        };
        //        PROCNT =         {
        //            label = Protein;
        //            quantity = "0.4732";
        //            unit = g;
        //        };
        //        SUGAR =         {
        //            label = "Sugars, total";
        //            quantity = "18.9098";
        //            unit = g;
        //        };
        //    };
        //}

}
