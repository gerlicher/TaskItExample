//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Ansgar Gerlicher on 03.01.15.
//  Copyright (c) 2015 Ansgar Gerlicher. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subtaskTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func canceButtonTabbed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTabbed(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectontext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectontext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectontext!)
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = datePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        var results:NSArray = managedObjectontext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
       
       self.dismissViewControllerAnimated(true , completion: nil)
        
    }
    

}
