//
//  RegisterViewController.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 15/12/20.
//

import Foundation
import UIKit
import RealmSwift
class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var gender: DropDown!
    @IBOutlet weak var registerButton: UIButton!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DropDown().optionArray = ["Male","Female"]
        gender.optionArray = ["Male","Female", "Not Disclosed"]
//        gender.optionIds = option.ids
//        mainDropDown.checkMarkEnabled = false
        gender.didSelect{ [self](selectedText , index , id) in
            view.endEditing(true)
            self.gender.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
            self.validate()
            
            
        }
        self.registerButton.isEnabled = false
        self.gender.delegate = self
        self.latitude.delegate = self
        self.longitude.delegate = self
    }
    //MARK:- UITextfiled Delegate
//    func textField(_ textField: UITextField, shouldChangeCharactersIn
//      range: NSRange, replacementString string: String) -> Bool {
//
//        if textField.tag == 6{
//
//            return false
//        }
//        return true
//    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == gender {
            return false; //do not show keyboard nor cursor
        }
        
        return true
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
    //MARK:- Register Action
    @IBAction func registerAction(_ sender: Any) {
        
//        guard userName.text == nil,email.text == nil,phoneNumber.text == nil,latitude.text == nil,longitude.text == nil,gender.text == nil  else {
//            print("All are nil")
//            DispatchQueue.main.async {
//            self.displayMsg(title: "Alert!", msg: "Please enter all fields.")
//            }
//            return
//        }
        let isphonevalid = isValidPhone(phone: phoneNumber.text!)
        let isemailvalid = isValidEmail(email: email.text!)
        let isusernamevalid = isValidUserName(username: userName.text!)
        print(isphonevalid, isemailvalid)
        print(isValidUserName(username: userName.text!))
        
        guard isusernamevalid else {
            DispatchQueue.main.async {
                        self.displayMsg(title: "Alert!", msg: "Please enter valid user.")
                        }
            return
        }
        guard isemailvalid else {
            DispatchQueue.main.async {
                        self.displayMsg(title: "Alert!", msg: "Please enter valid email.")
                        }
            return
        }
        guard isphonevalid else {
            DispatchQueue.main.async {
                        self.displayMsg(title: "Alert!", msg: "Please enter valid phone number.")
                        }
            return
        }
        
        
        let userRegistration = UserRegistation()
        userRegistration.name = userName.text
        userRegistration.emailID = email.text
        userRegistration.phoneNumber = phoneNumber.text
        userRegistration.latitude = Double(latitude.text!)!
        userRegistration.longitude = Double(longitude.text!)!
        userRegistration.gender = gender.text
        
        try! realm.write {
                   realm.add(userRegistration)
            DispatchQueue.main.async {
//                        self.displayMsg(title: "Alert!", msg: "User is sucessfully registered.")
                self.showAlertAction(title: "Alert!", message: "User is sucessfully registered.")
                        }
            
               }
        
    }
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Action")
            self.navigationController?.popViewController(animated: true)
            
        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- Validate
    func validate() {
        let text1 = self.userName?.text ?? ""
        let text2 = self.email?.text ?? ""
        let text3 = self.phoneNumber?.text ?? ""
        let text4 = self.latitude?.text ?? ""
        let text5 = self.longitude?.text ?? ""
        let text6 = self.gender?.text ?? ""

        if !text1.isEmpty && !text2.isEmpty && !text3.isEmpty && !text4.isEmpty && !text5.isEmpty && !text6.isEmpty {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
    //MARK: Phone Numebr
    func isValidUserName(username: String) -> Bool {
        print(realm.configuration.fileURL!)
        let result = realm.objects(UserRegistation.self).filter("name contains[c] '\(username)'")
        if result.count == 0{
            return true
        }
        else{
            return false
        }
        
    }
    
//    func isValidPhone(phone: String) -> Bool {
//        if phone.count > 9{
//            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
//            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//            return phoneTest.evaluate(with: phone)
//        }
//        else{
//            return false
//        }
//        }
//    //MARK: Email
//    func isValidEmail(email: String) -> Bool {
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//            return emailTest.evaluate(with: email)
//        }
//
//    //MARK: latitude let regex = NSRegularExpression("^-?[0-9]{1,3}[.]{1}[0-9]{6}$")
//    func isValidLatitude(latitude: String) -> Bool {
//        let latitudeRegEx = "^-?[0-9]{1,3}[.]{1}[0-9]{6}$"
//        let latitudeTest = NSPredicate(format:"SELF MATCHES %@", latitudeRegEx)
//        return latitudeTest.evaluate(with: latitude)
//    }
    
    
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
}

extension UIViewController {
    func displayMsg(title : String?, msg : String,
                    style: UIAlertController.Style = .alert,
          dontRemindKey : String? = nil) {
        if dontRemindKey != nil,
           UserDefaults.standard.bool(forKey: dontRemindKey!) == true {
            return
        }
        
        let ac = UIAlertController.init(title: title,
                   message: msg, preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
            style: .default, handler: nil))
        
        if dontRemindKey != nil {
            ac.addAction(UIAlertAction.init(title: "Don't Remind",
             style: .default, handler: { (aa) in
                UserDefaults.standard.set(true, forKey: dontRemindKey!)
                UserDefaults.standard.synchronize()
            }))
        }
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
    func isValidPhone(phone: String) -> Bool {
        if phone.count > 9{
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
        else{
            return false
        }
        }
    //MARK: Email
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    
    //MARK: latitude let regex = NSRegularExpression("^-?[0-9]{1,3}[.]{1}[0-9]{6}$")
    func isValidLatitude(latitude: String) -> Bool {
        let latitudeRegEx = "^-?[0-9]{1,3}[.]{1}[0-9]{6}$"
        let latitudeTest = NSPredicate(format:"SELF MATCHES %@", latitudeRegEx)
        return latitudeTest.evaluate(with: latitude)
    }
}

