//
//  assignedleaveTableViewCell.swift
//  Aiwin project
//
//  Created by iroid on 20/11/24.
//

import UIKit

class assignedleaveTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var leavetype: UILabel!
    @IBOutlet weak var days: UILabel!
}
