//
//  HomeViewController.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 16/12/20.
//

import Foundation
import UIKit
class HomeViewController: UIViewController{
    
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        adminButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        createButton.layer.cornerRadius = 5
        
    }
    //MARK:- Register Action
    @IBAction func adminLoginAction(_ sender: Any) {
//            let VC:AdminLoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminLoginViewController") as! AdminLoginViewController
//
//
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //MARK:- Register Action
    @IBAction func userLoginAction(_ sender: Any) {
//        DispatchQueue.main.async {
//            let VC:LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//
//        self.navigationController?.pushViewController(VC, animated: true)
//        }
    }
    //MARK:- Register Action
    @IBAction func createUser(_ sender: Any) {
//        DispatchQueue.main.async {
//            let VC:RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
//            
//            
//        self.navigationController?.pushViewController(VC, animated: true)
//        }
        
    }
}
