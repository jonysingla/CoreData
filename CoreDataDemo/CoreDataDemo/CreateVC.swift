//
//  CreateVC.swift
//  CoreDataToDo
//
//  Created by Kenta Kodashima on 2019-03-14.
//  Copyright © 2019 Kenta Kodashima. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var todoImage: UIImageView!
    @IBOutlet weak var todoNameField: UITextField!
    @IBOutlet weak var todoDescriptionField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var selectedImage = UIImage(named: "no-image.png")
    
    // MARK: - View controller life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: CreateVC.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: CreateVC.keyboardWillHideNotification, object: nil)
        
        todoNameField.delegate = self
        todoDescriptionField.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        stackView.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor)
        // Do the same for Y axis
        stackView.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerYAnchor)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: CreateVC.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: CreateVC.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped() {
        if isFieldEmpty() {
            displayEmptyFieldAlert()
        } else {
            let todo = ToDo(context: context)
            todo.todoName = todoNameField.text!
            todo.todoDescription = todoDescriptionField.text!
            todo.dateCreated = NSDate() as Date
            todo.todoImage = selectedImage!.pngData() as NSData? as! Data
            appDelegate.saveContext()
            
            resetFields()
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func resetFields() {
        todoNameField.text = ""
        todoDescriptionField.text = ""
        todoImage.image = UIImage(named: "no-image.png")
        selectedImage = UIImage(named: "no-image.png")
    }
    
    // Check all required fields are filled up
    private func isFieldEmpty() -> Bool {
        var empty = true
        
        switch empty {
        case todoNameField.text?.isEmpty:
            empty = true
        case todoDescriptionField.text?.isEmpty:
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
    
}

extension CreateVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Open up device's photo library
    @IBAction func pickPicture(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        setImagePicker(imagePicker: imagePicker)
        imagePicker.sourceType = .photoLibrary
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setImagePicker(imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 22)]
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get picked image from info directory
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        selectedImage = image
        
        todoImage.image = selectedImage
        
        // Take image picker off the screen
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateVC: UITextFieldDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        // Get width & height of the screen
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // Get the keyboard's final size
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // The bottom position of the stackview
        let stackBottom = stackView.frame.origin.y + stackView.frame.height + self.view.frame.origin.y
        // The top position of the keyboard
        let keyboardTop = screenHeight - keyboardFrame.size.height - 88.0
        // How much the keyboard overlaps the stackview
        let overlap =  stackBottom - keyboardTop
        
        if overlap >= 0 {
            // Move the contents up overlap value + 88.0
            scrollView.contentOffset.y = overlap + 88.0
            scrollView.isScrollEnabled = false
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        todoNameField.resignFirstResponder()
        todoDescriptionField.resignFirstResponder()
        
        return true
    }
}
