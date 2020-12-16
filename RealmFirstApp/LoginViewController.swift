//
//  LoginViewController.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 16/12/20.
//

import Foundation
import UIKit
import RealmSwift
class LoginViewController: UIViewController{
    @IBOutlet weak var userName: UITextField!
    var userObject: UserRegistation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.userName.text = ""
        
        self.userName.becomeFirstResponder()
        
    }
    //MARK:- Register Action
    @IBAction func adminLoginAction(_ sender: Any) {
        
        let realm = try! Realm()
        let username = userName.text
        if username!.isEmpty{
            self.displayMsg(title: "Alert!", msg: "Please enter user.")
        }
        else{
            let result = realm.objects(UserRegistation.self).filter("name contains[c] '\(username!)'")
            
            if result.count == 0{
                self.displayMsg(title: "Alert!", msg: "Please enter valid user.")
            }else{
                print(result)
                userObject = result[0] as UserRegistation
                DispatchQueue.main.async {
                    let VC:UpdateViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
                    VC.userObject = self.userObject


                self.navigationController?.pushViewController(VC, animated: true)
                }
                
            }
            
        }
        
        
       
    }
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
