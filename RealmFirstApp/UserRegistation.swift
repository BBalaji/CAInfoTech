//
//  UserRegistation.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 14/12/20.
//

import Foundation
import RealmSwift
class UserRegistation: Object {
    @objc dynamic var name : String?
    @objc dynamic var emailID : String?
    @objc dynamic var phoneNumber : String?
    @objc dynamic var latitude : Double = 0.0
    @objc dynamic var longitude : Double = 0.0
    @objc dynamic var gender : String?
}
