//
//  Article+CoreDataClass.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import Foundation
import CoreData

public class Article: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()

        self.createdDate = NSDate()
    }
}
