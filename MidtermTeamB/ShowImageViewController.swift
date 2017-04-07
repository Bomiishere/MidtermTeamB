//
//  ShowImageViewController.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {

    @IBOutlet weak var tableViewShowImage: UITableView!
    @IBOutlet weak var buttonAddImage: UIButton!
    var count = 10
    static let identifier: String = "ShowImageViewController"

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
    }

    func addImage() {
        print("Add image")
    }
}

extension ShowImageViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageShowingCell = self.tableViewShowImage.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }

//        imageShowingCell.imageShowing.image = UIImage(named: "hero_big-mac")
//        imageShowingCell.textLabel?.text = "Hello world!"
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
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            count -= 1
            tableView.endUpdates()
        }

    }
}
