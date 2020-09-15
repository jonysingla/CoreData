//
//  CreateViewController.swift
//  CoreDataSignup
//
//  Created by Jony on 31/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameField: UITextField!
    @IBOutlet weak var placeDescriptionField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var selectedImage = UIImage(named: "no-image.png")
    
    var fetchedRCGetData: NSFetchedResultsController<PlaceDetails>!
    var indexPath : IndexPath = []
//    let placeDetail : PlaceDetails
    //     var fetchedRCObjAtIndexPath: NSFetchedResultsController<PlaceDetails>!
    
    // MARK: - View controller life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (!indexPath.isEmpty) {
            print(fetchedRCGetData.object(at: indexPath))
            let obj = fetchedRCGetData.object(at: indexPath)
            placeNameField.text = obj.placeName
            placeDescriptionField.text = obj.placeDescription
            placeImage.image = UIImage(data: obj.placeImage! as Data)
            selectedImage = placeImage.image
        }
    }
    
    //MARK: Image selection
    @IBAction func selectImageTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        setImagePicker(imagePicker: imagePicker)
        imagePicker.sourceType = .photoLibrary
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    private func setImagePicker(imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 22) as Any]
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get picked image from info directory
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectedImage = image
        placeImage.image = selectedImage
        // Take image picker off the screen
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Button Action
    @IBAction func saveButtonTapped(_ sender: Any) {
        if isFieldEmpty() {
            displayEmptyFieldAlert()
        } else {
            let placeDetails = PlaceDetails(context: context)
            placeDetails.placeName = placeNameField.text!
            placeDetails.placeDescription = placeDescriptionField.text!
            placeDetails.placeImage = selectedImage!.pngData() as NSData?? as! Data
            placeDetails.dateCreated = NSDate() as Date
            
            appDelegate.saveContext()
            resetFields()
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func resetFields() {
        placeNameField.text = ""
        placeDescriptionField.text = ""
        placeImage.image = UIImage(named: "no-image.png")
        selectedImage = UIImage(named: "no-image.png")
    }
    
    // Check all required fields are filled up
    private func isFieldEmpty() -> Bool {
        var empty = true
        
        switch empty {
        case placeNameField.text?.isEmpty:
            empty = true
        case placeDescriptionField.text?.isEmpty:
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
