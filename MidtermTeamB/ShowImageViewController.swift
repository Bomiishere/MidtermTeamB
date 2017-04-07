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

    static let identifier: String = "ShowImageViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonAddImage.tintColor = .red
        self.buttonAddImage.addTarget(self, action: #selector(addImage), for: .touchUpInside)

        // TableView DataSource / Delegate
        self.tableViewShowImage.delegate = self
        self.tableViewShowImage.dataSource = self

        self.tableViewShowImage.register(UINib(nibName: ImageTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ImageTableViewCell.identifier)

        // Dynamic heigh
//        self.tableViewShowImage.estimatedRowHeight = 212
//        self.tableViewShowImage.rowHeight = UITableViewAutomaticDimension

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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageShowingCell = self.tableViewShowImage.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }

        return imageShowingCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212.0 // Dynamic height for cell
    }
}
