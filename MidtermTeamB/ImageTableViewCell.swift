//
//  ImageTableViewCell.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageShowing: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    static let identifier: String = "ImageTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.imageShowing.layer.cornerRadius = 8
//        self.imageShowing.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
