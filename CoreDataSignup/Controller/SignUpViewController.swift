//
//  SignUpViewController.swift
//  CoreDataSignup
//
//  Created by Jony on 29/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func signUpButtonButtonAction(_ sender: Any) {
        if isFieldEmpty() {
            displayEmptyFieldAlert()
        } else {
            let signup = Signup(context: context)
            signup.phoneNumber = phoneNumberTextField.text!
            signup.password = passwordTextField.text!
            signup.dateCreated = NSDate() as Date
            appDelegate.saveContext()
            resetFields()
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
        //          todoImage.image = UIImage(named: "no-image.png")
        //          selectedImage = UIImage(named: "no-image.png")
    }
}

