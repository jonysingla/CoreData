//
//  ViewController.swift
//  CoreDataTableViewWithAPI
//
//  Created by Jony on 22/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//
//http://jsonplaceholder.typicode.com/users


import UIKit
import CoreData

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var displayData = [DisplayDataModel]()
    
    let appDelegate :AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //     let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.callAPI()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        newUser.name = displayData[indexPath.row].name
        newUser.email = displayData[indexPath.row].email
        
        do {
            try context.save()
        } catch {}
        print("Object Saved.")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate (format: "name == %@", newUser.name!)
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let nameData = (result[0] as AnyObject).value(forKey: "name") as! String
                cell.nameLabel.text = newUser.name
                cell.emailLabel.text = newUser.email
            }
        }
        catch {
            //handle error
            print(error)
        }
        return cell
    }
    
    func callAPI() {
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
                        self.displayData.append(DisplayDataModel(name: name, username: username,email : email))
                    }
                    self.tableView.reloadData()
                }
                catch{
                    print("Error 2")
                }
            }
        }
        task.resume()
    }
}

