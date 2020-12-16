//
//  AllRegisterViewControler.swift
//  RealmFirstApp
//
//  Created by Besta, Balaji (623-Extern) on 16/12/20.
//

import Foundation
import UIKit
import RealmSwift
class AllRegisterViewControler: UIViewController {
    
    @IBOutlet var tableview: UITableView!
    var allObjects : [UserRegistation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(SubtitleTableViewCell.self, forCellReuseIdentifier:SubtitleTableViewCell.identifier)
        let realm = try! Realm()
        let result = realm.objects(UserRegistation.self)
        print(result.count)
//        print(result[0].name, result[0].emailID)
        if result.count > 0{
            for item in result{
                allObjects.append(item)
                tableview.reloadData()
            }
        }
        else{
            print("no objects")
        }
        
    }

    
}

///MARK: UITableViewDataSource
extension AllRegisterViewControler: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allObjects.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel?.text = allObjects[indexPath.row].name
            cell.detailTextLabel?.text = allObjects[indexPath.row].emailID
        cell.selectionStyle = .none
        return cell
    }
    
}
///MARK: UITableViewDataSource
extension AllRegisterViewControler: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let VC:ReverseGeocodingViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReverseGeocodingViewController") as! ReverseGeocodingViewController
            VC.userObject = self.allObjects[indexPath.row]


        self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
}
