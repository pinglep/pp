//
//  docviewappTableViewCell.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class docviewappTableViewCell: UITableViewCell {
    @IBOutlet weak var patName: UILabel!
    
    @IBOutlet weak var cellDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
