//
//  TaskModel.swift
//  TaskIt
//
//  Created by Ansgar Gerlicher on 06.01.15.
//  Copyright (c) 2015 Ansgar Gerlicher. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel) //creates Obj-C Bridge
class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String

}
