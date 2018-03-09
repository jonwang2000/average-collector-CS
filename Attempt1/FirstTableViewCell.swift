//
//  FirstTableViewCell.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-03-04.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var CourseNameLabel: UILabel!
    @IBOutlet weak var AverageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
