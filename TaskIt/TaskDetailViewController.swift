//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Ansgar Gerlicher on 02.01.15.
//  Copyright (c) 2015 Ansgar Gerlicher. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(self.detailTaskModel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
