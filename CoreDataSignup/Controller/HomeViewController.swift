//
//  HomeViewController.swift
//  CoreDataSignup
//
//  Created by Jony on 31/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: - Properties
    private var fetchedRC: NSFetchedResultsController<PlaceDetails>!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View controller life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let request = PlaceDetails.fetchRequest() as NSFetchRequest<PlaceDetails>
        let sort = NSSortDescriptor(key: #keyPath(PlaceDetails.dateCreated), ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fetchData = fetchedRC.fetchedObjects else { return 0 }
        //        return fetchData.count
        
        let noPlacesLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let numOfSections: Int = fetchData.count
        
        if (fetchData.count == 0) {
            noPlacesLabel.text          = "No places are found, Tap on Add button to Add some places."
            noPlacesLabel.textColor     = UIColor.black
            noPlacesLabel.textAlignment = .center
            noPlacesLabel.numberOfLines = 2
            homeTableView.backgroundView  = noPlacesLabel
            homeTableView.separatorStyle  = .none
            return numOfSections
        } else {
            tableView.backgroundView?.isHidden = true
            return numOfSections
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        let obj = fetchedRC.object(at: indexPath)
        cell.placeName.text = obj.placeName
        cell.placeDescription.text = obj.placeDescription
        
        if let data = obj.placeImage as Data? {
            cell.placeImage.image = UIImage(data: data)
        } else {
            cell.placeImage.image = UIImage(named: "no-image.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let obj = fetchedRC.object(at: indexPath)
            context.delete(obj)
            appDelegate.saveContext()
            homeTableView.reloadData()
        }
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateVC") as! CreateViewController
        vc.fetchedRCGetData = fetchedRC
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Update data on Core DataBase
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        
        guard let cellIndex = index else { return }
        
        switch type {
        case .insert:
            homeTableView.insertRows(at: [cellIndex], with: .fade)
        case .delete:
            homeTableView.deleteRows(at: [cellIndex], with: .left)
            //        case .update
        //            homeTableView.deleteRows(at: [cellIndex], with: .left)
        default:
            break
        }
    }
}


