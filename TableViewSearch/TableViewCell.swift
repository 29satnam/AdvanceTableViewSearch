//
//  cell.swift
//  searchShit
//
//  Created by Satnam Sync on 24/08/15.
//  Copyright (c) 2015 Satnam Sync. All rights reserved.
//

import UIKit

class CollectionViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var greetingTextLabel: UILabel!
    
    func configureForItem(item: AnyObject?) {
        if let greeting:Greeting = item as? Greeting {
            self.label.text = greeting.language
            self.greetingTextLabel.text = greeting.greetingText
        }
    }
}
