//
//  ViewController.swift
//  APIwithCoreData
//
//  Created by Jony on 22/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var displayDatasssss = [displyDataClass]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tap(_ sender: Any) {
        let url = "http://jsonplaceholder.typicode.com/users"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){(data, response,error)in
            if (error != nil){
                print("Error")
            }
            else{
                do{
                    // Array of Data
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    for eachData in fetchData {
                        
                        let eachdataitem = eachData as! [String : Any]
                        let name = eachdataitem["name"]as! String
                        let username = eachdataitem["username"]as! String
                        
                        let email = eachdataitem["email"]as! String
                        self.displayDatasssss.append(displyDataClass(name: name, username: username,email : email))
                    }
//                    self.tableView.reloadData()
                }
                catch{
                    print("Error 2")
                }
                
            }
        }
        task.resume()
        
    }
    
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        let _:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as NSManagedObject
//        print("Name ---- ", newUser.)
//        newUser.setValue(cell.label.text, forKey: "name")
        
        do {
            try context.save()
        } catch {}
        print(newUser)
        print("Object Saved.")
        
    }
}



class displyDataClass {
    var name : String
    var username : String
    var email : String
    
    init(name : String,username : String,email :String) {
        self.name = name
        self.username = username
        self.email = email
    }
}
