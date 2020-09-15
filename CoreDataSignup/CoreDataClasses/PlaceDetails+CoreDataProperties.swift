//
//  PlaceDetails+CoreDataProperties.swift
//  CoreDataSignup
//
//  Created by Jony on 31/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//
//

import Foundation
import CoreData


extension PlaceDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceDetails> {
        return NSFetchRequest<PlaceDetails>(entityName: "PlaceDetail")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var placeDescription: String?
    @NSManaged public var placeImage: Data?
    @NSManaged public var placeName: String?

}
