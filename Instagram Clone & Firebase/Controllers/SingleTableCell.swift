//
//  SingleTableCell.swift
//  Instagram Clone & Firebase
//
//  Created by Coder ACJHP on 24.06.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class SingleTableCell: UITableViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var userNameField: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContainer.backgroundColor = UIColor.white
        cellContainer.layer.borderWidth = 1.0
        cellContainer.layer.cornerRadius = 4.0
        cellContainer.layer.borderColor = UIColor.white.cgColor
        
        
        imageContainer.layer.cornerRadius = 3.0
        commentField.layer.borderWidth = 0.4
        commentField.layer.cornerRadius = 3.0
        commentField.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
