//
//  MealListController.swift
//  Mealy
//
//  Created by Danny Dong on 4/23/22.
//

import UIKit
import Firebase

class MealListController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var meals = Meals.meals.allMeals
    var mealNames = Array(Meals.meals.allMeals.keys)

    var filteredData: [String] = Array(Meals.meals.allMeals.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        meals = Meals.meals.allMeals
        mealNames = Array(Meals.meals.allMeals.keys)
        filteredData = mealNames
        tableView.reloadData()
    }

    @IBAction func onLogOutPress(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        try? firebaseAuth.signOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal") as!  MealCell
        
        cell.mealNameLabel.text = filteredData[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Meals.meals.chosenMeal = mealNames[indexPath.row]
        let main = UIStoryboard(name: "Main", bundle: nil)
        let MealListController = main.instantiateViewController(withIdentifier: "Meal Summary Navigation") as! UINavigationController
        self.present(MealListController, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []

        if searchText == "" {
            filteredData = Array(Meals.meals.allMeals.keys)
            tableView.reloadData()
            return
        }

        for meal in mealNames {
            let mealName = meal.lowercased()
            if mealName.contains(searchText.lowercased()) {
                filteredData.append(mealName)
            }
        }
        tableView.reloadData()
     }
   
}
