//
//  LoginViewController.swift
//  CoreDataSignup
//
//  Created by Jony on 29/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    var result = NSArray()
    var predicate: NSPredicate?
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = Signup.fetchRequest() as NSFetchRequest<Signup>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if isFieldEmpty() {
            displayEmptyFieldAlert()
        } else {
            self.CheckForUserNameAndPasswordMatch(phoneNumber: phoneNumberTextField.text!, password: passwordTextField.text! )
        }
    }
    
    // Check all required fields are filled up
    private func isFieldEmpty() -> Bool {
        var empty = true
        
        switch empty {
        case phoneNumberTextField.text?.isEmpty:
            empty = true
        case passwordTextField.text?.isEmpty:
            empty = true
        default:
            empty = false
        }
        return empty
    }
    
    private func displayEmptyFieldAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("Required field is empty.", comment: ""),
            message: NSLocalizedString("Please fill out all the fields.", comment: ""),
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func resetFields() {
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
    }
    
    func CheckForUserNameAndPasswordMatch(phoneNumber: String, password : String) {
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //        let request = Signup.fetchRequest() as NSFetchRequest<Signup>
        //        let predicate = NSPredicate (format:"phoneNumber = %@" ,phoneNumber)
        
        predicate = NSPredicate (format:"phoneNumber = %@" ,phoneNumber)
        request.predicate = predicate
        do
        {
            result = try managedObjectContext.fetch(request) as NSArray
            if result.count>0 {
                for data in result as! [NSManagedObject] {
                    let phoneNumberVer = data.value(forKey: "phoneNumber")as! String
                    let passwordVer = data.value(forKey: "password")as! String
                    if (phoneNumberTextField.text == phoneNumberVer && passwordTextField.text == passwordVer) {
                        print("Login Succesfully")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        print("Please enter correct username and password")
                    }
                    //                    guard (phoneNumberTextField.text == phoneNumberVer && passwordTextField.text == passwordVer) else {
                    //                        print("Please enter correct password")
                    //                        return
                    //                    }
                }
                
            } else {
                print("Please enter correct Mobile Number")
            }
        }
            
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
    }
}

