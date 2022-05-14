//
//  RegisterViewController.swift
//  Mealy
//
//  Created by Danny Dong on 4/23/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        emailField.setLeftImage(imageName: "email.jpeg")
        passwordField.setLeftImage(imageName: "lock.jpeg")
        usernameField.setLeftImage(imageName: "profile.jpeg")
        emailField.layer.cornerRadius = 15
        passwordField.layer.cornerRadius = 15
        usernameField.layer.cornerRadius = 15
        signUpButton.layer.cornerRadius = 15
    }
    
    @IBAction func onSignUpPress(_ sender: Any) {
        if let email = emailField.text {
            if let password = passwordField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                        return
                    }
                    
                    self.performSegue(withIdentifier: "RegisterToMeals", sender: self)
                }
            }
        }
    }
}
