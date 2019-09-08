//
//  CoreHistory+CoreDataProperties.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/8/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreHistory> {
        return NSFetchRequest<CoreHistory>(entityName: "CoreHistory")
    }

    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?

}
