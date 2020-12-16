//
//  AdminLoginViewController.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 16/12/20.
//

import Foundation
import UIKit
import RealmSwift
class AdminLoginViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.isEnabled = false
        self.userName.delegate = self
        self.passWord.delegate = self
        let realm = try! Realm()
         
         //// Get our Realm file's parent directory
        
         
         print(realm.configuration.fileURL!)
         
        let result = realm.objects(Admin.self).filter("name = 'admin'")
        print(result.count)
        if result.count == 0 {
            
            let admin = Admin()
            admin.name = "admin"
            admin.password = "admin"
            try! realm.write {
                realm.add(admin)
            }
            print("admin account created!")
        }
        else{
            print("admin account is there")
           
        }
        
        
         
 //        try! realm.write {
 //            realm.add(userRegistration)
 //        }
         
 //        let result = realm.objects(UserRegistation.self).filter("name = 'Balaji'")
 //        print(result.count)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.userName.text = ""
        self.passWord.text = ""
        self.loginButton.isEnabled = false
        self.userName.becomeFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Try to find next responder
          if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
             nextField.becomeFirstResponder()
          } else {
             // Not found, so remove keyboard.
             textField.resignFirstResponder()
          }
          // Do not add a line break
          return false
       }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validate()
    }
    //MARK:- Admin Action
    @IBAction func adminLoginAction(_ sender: Any) {
        
        let realm = try! Realm()
        let username = self.userName?.text ?? ""
        let password = self.passWord?.text ?? ""
        

        if !username.isEmpty && !password.isEmpty {
            print(username,password)
            let result = realm.objects(Admin.self).filter("name = '\(username)' && password = '\(password)'")
            print(result.count)
            if result.count > 0 {
                DispatchQueue.main.async {
                        let VC:AllRegisterViewControler = self.storyboard?.instantiateViewController(withIdentifier: "AllRegisterViewControler") as! AllRegisterViewControler
                self.navigationController?.pushViewController(VC, animated: true)
                }
            }
            else{
                print("Something went wwrong")
            }
        } else {
            DispatchQueue.main.async {
                        self.displayMsg(title: "Alert!", msg: "Please enter Both feilds.")
                        }
        }
        
        
    }
    
    //MARK:- Validate
    func validate() {
        let text1 = self.userName?.text ?? ""
//        let text2 = self.passWord?.text ?? ""
        

        if !text1.isEmpty {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
