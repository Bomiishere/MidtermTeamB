//
//  ShowImageViewController.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import UIKit
import CoreData

class ShowImageViewController: UIViewController {

    @IBOutlet weak var tableViewShowImage: UITableView!
    @IBOutlet weak var buttonAddImage: UIButton!
    var count = 10
    static let identifier: String = "ShowImageViewController"
    var fetchedResultsController: NSFetchedResultsController<Article>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonAddImage.tintColor = .red
        self.buttonAddImage.addTarget(self, action: #selector(addImage), for: .touchUpInside)

        // TableView DataSource / Delegate
        self.tableViewShowImage.delegate = self
        self.tableViewShowImage.dataSource = self

        self.tableViewShowImage.register(UINib(nibName: ImageTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ImageTableViewCell.identifier)

        // Hide the indicator
        self.tableViewShowImage.showsHorizontalScrollIndicator = false
        self.tableViewShowImage.showsVerticalScrollIndicator = false
        self.tableViewShowImage.separatorStyle = .none
        
        //fetchDataResult
        fetchCoreDataResult()
    }

    func addImage() {
        print("Add imageaaa")
    }
}

extension ShowImageViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {

        if let sections = fetchedResultsController.sections {
            return sections.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let sections = fetchedResultsController.sections {

            let sectionInfo = sections[0]
            return sectionInfo.numberOfObjects

        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageShowingCell = self.tableViewShowImage.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }

        imageShowingCell.configureCell(article: fetchedResultsController.object(at: indexPath))

        return imageShowingCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212.0 // Dynamic height for cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addImageViewController = mainStoryboard.instantiateViewController(withIdentifier: AddImageViewController.identifier) as? AddImageViewController else { return }
        self.show(addImageViewController, sender: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == UITableViewCellEditingStyle.delete {

            deleteData(for: indexPath.row)

        }

    }
}

// CoreData
extension ShowImageViewController: NSFetchedResultsControllerDelegate {

    func fetchCoreDataResult() {

        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        //sort by
        let dateSort = NSSortDescriptor(key: "createdDate", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self

        do {

            try fetchedResultsController.performFetch()

        } catch {

            //TODO: Err
            let error = error as NSError
            print(error)

        }

    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableViewShowImage.beginUpdates()

    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableViewShowImage.endUpdates()

    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {

        case .insert:

            if let indexPath = newIndexPath {

                UIView.animate(withDuration: 0.4, animations: {
                    self.tableViewShowImage.insertRows(at: [indexPath], with: .fade)
                }, completion: { (_) in

                    //allow new added row to see
                    UIView.animate(withDuration: 0.1, animations: {
                        self.tableViewShowImage.scrollToRow(at: indexPath,
                                                       at: .bottom,
                                                       animated: true)

                    }, completion: { (_) in
                        // ?? can't work
                        //get add cell and ready to type
//                        if let addCell = self.tableViewShowImage.cellForRow(at: indexPath) as? tableViewShowImageCell {
//                            addCell.textView.becomeFirstResponder()
//                        }
                    })

                })

            }

        case .delete:

            if let indexPath = indexPath {
                tableViewShowImage.deleteRows(at: [indexPath], with: .fade)
            }

        case .update:

            if let indexPath = indexPath {
                tableViewShowImage.reloadRows(at: [indexPath], with: .fade)
            }

        case .move:

            if let indexPath = indexPath {
                tableViewShowImage.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableViewShowImage.insertRows(at: [indexPath], with: .fade)
            }

        }

    }

}
