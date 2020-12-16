//
//  UpdateViewController.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 16/12/20.
//

import Foundation

import UIKit
import RealmSwift
class UpdateViewController: UIViewController{
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var gender: DropDown!
    @IBOutlet weak var updateButton: UIButton!
    var userObject : UserRegistation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ((userObject?.name?.isEmpty) != nil){
            userName.text = userObject?.name
            email.text = userObject?.emailID
            phoneNumber.text = userObject?.phoneNumber
            latitude.text = String(userObject!.latitude)
            longitude.text = String(userObject!.longitude)
            gender.text = userObject?.gender
        }
        else{
            print("no object")
        }
        gender.optionArray = ["Male","Female", "Not Disclosed"]
        gender.didSelect{ [self](selectedText , index , id) in
            view.endEditing(true)
            self.gender.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
            
            
        }
        
    }
    //MARK:- Register Action
    @IBAction func adminLoginAction(_ sender: Any) {
        
        let realm = try! Realm()
        
        let isphonevalid = isValidPhone(phone: phoneNumber.text!)
        let isemailvalid = isValidEmail(email: email.text!)
        
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
        
        
        let username = userName.text
        let workouts = realm.objects(UserRegistation.self).filter("name contains[c] '\(username!)'")

        print(workouts.count)
        if let workout = workouts.first {
            try! realm.write {
                workout.emailID = email.text
                workout.phoneNumber = phoneNumber.text
                workout.latitude = Double(latitude.text!)!
                workout.longitude = Double(longitude.text!)!
                workout.gender = gender.text
                DispatchQueue.main.async {
                            self.displayMsg(title: "Alert!", msg: "User is sucessfully updated.")
                            }
                
            }
        }
        
        
    }
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
