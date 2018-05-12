//
//  doctorTableViewCell.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/24/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class doctorTableViewCell: UITableViewCell {

    @IBOutlet weak var roleText: UILabel!
    @IBOutlet weak var firstname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
