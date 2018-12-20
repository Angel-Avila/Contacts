//
//  StringCell.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class StringCell: GenericTableViewCell<String> {
    override var item: String! {
        didSet {
            guard let label = textLabel, let item = item else { return }
            label.font = UIFont(name: "AvenirNext-Regular", size: 17)
            label.textColor = .darkGray
            label.text = "\(item)"
        }
    }
}
