//
//  AddMealTableViewController.swift
//  Mealy
//
//  Created by Danny Dong on 5/4/22.
//

import UIKit

class AddMealTableViewController: UITableViewController, AddMeal {
    
    @IBOutlet weak var mealNameLabel: UITextField!
    // ingredient name: nutrients
    var ingredientList = Meals.meals.analyzedIngredientList
    // [(name: String, portion: String)]
    var ingredients = Meals.meals.currentIngredientList
    var mealHandler = MealHandler()
    var mealSummary = MealSummary()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealHandler.delegate = self
    
    }

    override func viewDidAppear(_ animated: Bool) {
        if let storedData = UserDefaults.standard.data(forKey: "ingredients") {
            let storedIngredients = try! PropertyListDecoder().decode([Ingredient].self, from: storedData)
            Meals.meals.currentIngredientList = storedIngredients
        }
        ingredients = Meals.meals.currentIngredientList
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
        
        let ingredient = ingredients[indexPath.row]
        let ingredientName = ingredient.name
        let ingredientPortion = ingredient.portion
        
        cell.ingredientLabel.text = ingredientName
        cell.portionLabel.text = ingredientPortion
        return cell
    }

    @IBAction func onDonePress(_ sender: Any) {
        if mealNameLabel.text == nil || mealNameLabel.text?.isEmpty == true {
            return
        }

        for i in 0..<self.ingredients.count {
            let ingredient = self.ingredients[i]
            let ingredientInfo = "\(ingredient.name) \(ingredient.portion)"
            Task {
                await self.getNutritionAnalysis(ingredientInfo)
                if i == self.ingredients.count - 1 {
                    mealHandler.addMeal(mealNameLabel.text!, mealSummary)
                    Meals.meals.currentIngredientList = []
                    UserDefaults.standard.removeObject(forKey: "ingredients")
      
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let MealListController = main.instantiateViewController(withIdentifier: "Meal List Navigation") as! UINavigationController
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let delegate = windowScene.delegate as? SceneDelegate else {return}
                    delegate.window?.rootViewController = MealListController
                }
            }
        }
    }
   
    
    func getNutritionAnalysis(_ ingredient: String) async {
        let parsedIngredient = ingredient.split(separator: " ").joined(separator: "%20")
        
//        let headers = [
//            "X-RapidAPI-Host": "edamam-edamam-nutrition-analysis.p.rapidapi.com",
//            "X-RapidAPI-Key": "affdfba979msh133d0f1bd3bf64fp173437jsnc6c0165086e6"
//        ]
        let headers = [
            "X-RapidAPI-Host": "edamam-edamam-nutrition-analysis.p.rapidapi.com",
            "X-RapidAPI-Key": "4f3c949941msh210b753a07a53e2p14b3c1jsn00d8adf1bd74"
        ]
        guard let url = URL(string: "https://edamam-edamam-nutrition-analysis.p.rapidapi.com/api/nutrition-data?ingr=\(parsedIngredient)") else {return }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let res = try JSONDecoder().decode(NutritionAnalysis.self, from: data)
            self.ingredientList[ingredient] = res
            addToSummary(ingredient)
//            logIngredientsInfo(ingredient)
            

        } catch  {
            return
        }
        
    }
 
    func addToSummary(_ ingredient: String) {
        if let info = ingredientList[ingredient] {
            let totalNutrients = info.totalNutrients
            
            mealSummary.calories = roundToTwoDecimalPlaces(mealSummary.calories + totalNutrients.calories)
            mealSummary.protein = roundToTwoDecimalPlaces(mealSummary.protein + totalNutrients.protein)
            mealSummary.calcium = roundToTwoDecimalPlaces(totalNutrients.calcium + mealSummary.calcium)
            mealSummary.sodium = roundToTwoDecimalPlaces(mealSummary.sodium + totalNutrients.sodium)
            mealSummary.fat = roundToTwoDecimalPlaces(mealSummary.fat + totalNutrients.fat)
            mealSummary.carbs = roundToTwoDecimalPlaces(mealSummary.carbs + totalNutrients.carbs)
            mealSummary.cholesterol = roundToTwoDecimalPlaces(mealSummary.cholesterol + totalNutrients.cholesterol)
        }
    }
    
    func roundToTwoDecimalPlaces(_ amount: Double) -> Double {
        return round(amount * 100) / 100.0
    }
    
    @IBAction func onBackPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func logIngredientsInfo(_ ingredient: String) {
        print("ingredient: \(ingredient)")
        if let info = ingredientList[ingredient] {
            let totalNutrients = info.totalNutrients
            print("Calories: \(totalNutrients.calories)kcal")
            print("Protein: \(totalNutrients.protein)g")
            print("Calcium: \(totalNutrients.calcium)mg")
            print("Sodium: \(totalNutrients.sodium)mg")
            print("Fat: \(totalNutrients.fat)g")
            print("Carbs: \(totalNutrients.carbs)g")
            print("Cholesteral: \(totalNutrients.cholesterol)mg")
        }
    }
    
    func addMeal(_ mealName: String, _ mealSummary: MealSummary) {
        Meals.meals.allMeals[mealName] = mealSummary
    }
    
}
