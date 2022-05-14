//
//  LoginViewController.swift
//  Mealy
//
//  Created by Danny Dong on 4/22/22.
//

import UIKit
import Firebase

// 1@3.com 123456
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.onSignUpTap))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tap)
        
        
        
        emailField.setLeftImage(imageName: "email.jpeg")
        passwordField.setLeftImage(imageName: "lock.jpeg")
        emailField.layer.cornerRadius = 15
        passwordField.layer.cornerRadius = 15
        signInButton.layer.cornerRadius = 15
    }
    
    @objc func onSignUpTap(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "Register")
        self.navigationController?.pushViewController(registerVC, animated: true)
        self.present(registerVC, animated: true, completion: nil)
    }
    
    @IBAction func onSignInPress(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    return
                }

                self.performSegue(withIdentifier: "LoginToMeals", sender: self)
            }
        }
    }
    


}

extension UITextField {
    
    func setLeftImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
       imageView.image = UIImage(named: imageName)
       let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
       imageContainerView.addSubview(imageView)
       leftView = imageContainerView
       leftViewMode = .always
       self.tintColor = .lightGray
    }
}
