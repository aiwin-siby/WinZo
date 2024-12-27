//
//  diaryTableViewCell.swift
//  Aiwin project
//
//  Created by iroid on 20/11/24.
//

import UIKit

class diaryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var numberbtn: UIButton!
    @IBOutlet weak var deletebtn: UIButton!
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var diarydate: UILabel!
    @IBOutlet weak var diaryheading: UILabel!
}
