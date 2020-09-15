//
//  User+CoreDataProperties.swift
//  CoreDataTableViewWithAPI
//
//  Created by Jony on 22/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() ->
        NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?


}
