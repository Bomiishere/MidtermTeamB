//
//  Article+CoreDataProperties.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var createdDate: NSDate?
    @NSManaged public var imageData: NSData?

}
