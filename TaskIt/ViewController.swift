//
//  ViewController.swift
//  TaskIt
//
//  Created by Ansgar Gerlicher on 02.01.15.
//  Copyright (c) 2015 Ansgar Gerlicher. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    
  
    @IBOutlet weak var myTableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
    }
   
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }

    @IBAction func addButtonTabbed(sender: UIBarButtonItem) {
    
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            let indexPath = self.myTableView.indexPathForSelectedRow()
            println("indexPath for selected row: \(indexPath)")
            let detailTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            println("Detailtask: \(detailTask)")
            detailVC.detailTaskModel = detailTask
            
        }
        
        else if segue.identifier == "showTaskAdd" {
            
            let addVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            
            
        }
        
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return fetchedResultsController.sections![section].numberOfObjects
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        

        let mytask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        cell.taskLabel.text = mytask.task
        cell.descriptionLabel.text = mytask.subtask
        cell.dateLabel.text = Date.toString(date: mytask.date)

        return cell
    }
    
    // UITabelViewDelegate
    
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("selected section: \(indexPath.section), indexPath \(indexPath)s")

        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return "To Do"
        case 1:
            return "Completed"
        default:
            return "No Idea"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        //baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            thisTask.completed = true
            
        }
        else {
           thisTask.completed = false
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        
    }
    
    // NSFetchedResultsController Delegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        myTableView.reloadData()
    }
    
    //Helper
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        return fetchRequest
        
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: "taskcache")
        return fetchedResultsController
        
    }
    
    
}

