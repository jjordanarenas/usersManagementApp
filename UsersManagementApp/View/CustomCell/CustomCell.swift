//
//  CustomCell.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.idLabel.text = nil
        self.birthdayLabel.text = nil
    }
}
