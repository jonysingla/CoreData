//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Jony on 28/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//
// https://medium.com/@KentaKodashima/ios-core-data-tutorial-part-2-41f6740865d5

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var todoTableView: UITableView!
    
    // MARK: - Properties
    private var fetchedRC: NSFetchedResultsController<ToDo>!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View controller life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let request = ToDo.fetchRequest() as NSFetchRequest<ToDo>
        let sort = NSSortDescriptor(key: #keyPath(ToDo.dateCreated), ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todos = fetchedRC.fetchedObjects else { return 0 }
        
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        let todo = fetchedRC.object(at: indexPath)
        
        cell.todoName.text = todo.todoName
        cell.todoDescription.text = todo.todoDescription
        
        if let data = todo.todoImage as Data? {
            cell.todoImage.image = UIImage(data: data)
        } else {
            cell.todoImage.image = UIImage(named: "no-image.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = fetchedRC.object(at: indexPath)
            context.delete(todo)
            appDelegate.saveContext()
            todoTableView.reloadData()
        }
    }
    
}

    extension ViewController: NSFetchedResultsControllerDelegate {
      func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        
        guard let cellIndex = index else { return }
        
        switch type {
        case .insert:
          todoTableView.insertRows(at: [cellIndex], with: .fade)
        case .delete:
          todoTableView.deleteRows(at: [cellIndex], with: .left)
        default:
          break
        }
      }
    }



