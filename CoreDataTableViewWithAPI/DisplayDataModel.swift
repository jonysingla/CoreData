//
//  DisplayDataModel.swift
//  CoreDataTableViewWithAPI
//
//  Created by Jony on 22/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit

class DisplayDataModel: NSObject {
    var name : String
    var username : String
    var email : String
    
    init(name : String,username : String,email :String) {
        self.name = name
        self.username = username
        self.email = email
    }
}
