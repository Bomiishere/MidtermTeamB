//
//  CoreDataModel.swift
//  MidtermTeamB
//
//  Created by Lucy on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import CoreData
import UIKit

// swiftlint:disable:next force_cast
let appDelegate = UIApplication.shared.delegate as! AppDelegate
// swiftlint:disable:previous force_cast

func addCoreDataArticle(content: String?, title: String?, imageData: NSData?) {

    let moc = appDelegate.persistentContainer.viewContext
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: moc) else { return }

    let insertArticle = Article(entity: entityDescription, insertInto: moc)
    insertArticle.content = content
    insertArticle.title = title
    insertArticle.imageData = imageData

}

func getSingleCoreDataArticle(for row: Int) -> Article? {

    let moc = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
    do {

        guard let results = try moc.fetch(request) as? [Article] else {
            return nil
        }

        return results[row]

    } catch {
        fatalError("\(error)")
    }

}

func updateCoreDataContent(row: Int, content: String?, title: String?, imageData: NSData?) {

    if row < 0 { // row == 0 is first item of data
        return
    } else {
        let moc = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {

            guard let results = try moc.fetch(request) as? [Article] else {
                return
            }

            if row >= results.count {
                //add
                guard let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: moc) else { return }
                let insertArticle = Article(entity: entityDescription, insertInto: moc)
                insertArticle.content = content
                insertArticle.title = title
                insertArticle.imageData = imageData

            } else {
                //update
                if let content = content {
                    results[row].content = content
                }
                if let title = title {
                    results[row].title = title
                }
                if let imageData = imageData {
                    results[row].imageData = imageData
                }
            }
            print(results.count)
        } catch {
            fatalError("\(error)")
        }
    }
}

func deleteData(for row: Int) {

    let moc = appDelegate.persistentContainer.viewContext

    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Content")

    do {

        guard let results = try moc.fetch(request) as? [Article] else {
            return
        }

        moc.delete(results[row])

    } catch {
        fatalError("\(error)")
    }
}
