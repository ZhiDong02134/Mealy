//
//  AddIngredientViewController.swift
//  Mealy
//
//  Created by Danny Dong on 5/4/22.
//

import UIKit

class AddIngredientViewController: UIViewController {

    @IBOutlet weak var portionField: UITextField!
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var quoteLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    var ingredientList = Meals.meals.currentIngredientList
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await getQuote()
        }
    }
    
    
    
    @IBAction func onAddPress(_ sender: Any) {
        if let portion = portionField.text, let ingredient = ingredientField.text {
            if portion.isEmpty == false && ingredient.isEmpty == false {
                ingredientList.append(Ingredient(name: ingredient, portion: portion))
                Meals.meals.currentIngredientList = ingredientList
//                print(Meals.meals.currentIngredientList)
                
        do {
            let ingredientsData = try PropertyListEncoder().encode(Meals.meals.currentIngredientList)
            defaults.set(ingredientsData, forKey: "ingredients")
        } catch {
            print("Unable to store data in UserDefaults")
        }

        }
        }
        portionField.text = ""
        ingredientField.text = ""
    }
    
    @IBAction func onBackPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    func getQuote() async {
        let headers = [
            "X-RapidAPI-Host": "inspiring-quotes.p.rapidapi.com",
            "X-RapidAPI-Key": "affdfba979msh133d0f1bd3bf64fp173437jsnc6c0165086e6"
        ]
        
        guard let url = URL(string: "https://inspiring-quotes.p.rapidapi.com/random") else {return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let res = try JSONDecoder().decode(Quote.self, from: data)
            self.quoteLabel.text = res.quote
        } catch  {
            return
        }
        
    }
}
