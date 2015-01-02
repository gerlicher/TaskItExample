//
//  ViewController.swift
//  TaskIt
//
//  Created by Ansgar Gerlicher on 02.01.15.
//  Copyright (c) 2015 Ansgar Gerlicher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
  
    @IBOutlet weak var myTableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verb", date: "01/14/2014")
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: "01/15/2015")
        
        taskArray = [task1,task2,TaskModel(task: "Gym", subTask: "Leg day", date: "01/16/2015") ]
        
        
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
            let detailTask = taskArray[indexPath!.row]
            println(detailTask)
        }
        
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("Section: \(indexPath.section) row: \(indexPath.row)")
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        

        let mytask = taskArray[indexPath.row]
        cell.taskLabel.text = mytask.task
        cell.descriptionLabel.text = mytask.subTask
        cell.dateLabel.text = mytask.date

        return cell
    }
    
    // UITabelViewDelegate
    
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("selected section: \(indexPath.section), indexPath \(indexPath)s")

        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
        
        
    }
    
}

