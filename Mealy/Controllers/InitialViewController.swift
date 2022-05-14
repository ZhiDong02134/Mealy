//
//  InitialViewController.swift
//  Mealy
//
//  Created by Danny Dong on 5/8/22.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {
    
    private var background: UIImageView? = nil
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.image = UIImage(named: "smoothie")
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        
        background = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        background!.image = UIImage(named: "health")
        
        
        view.addSubview(background!)
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        background?.center = view.center

        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.animate()
        }
    }

    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
            self.imageView.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let MealListController = main.instantiateViewController(withIdentifier: "LoginViewController")
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let delegate = windowScene.delegate as? SceneDelegate else {return}
                    delegate.window?.rootViewController = MealListController
                }
            }
        })
        
    }

}

