//
//  contactTableViewCell.swift
//  Aiwin project
//
//  Created by iroid on 04/12/24.
//

import UIKit

class contactTableViewCell: UITableViewCell {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Method to configure the cell with the contact information
    func configureCell(name: String, contact: String, isTeacher: Bool) {
        namelabel.text = name
        numberbutton.setTitle(contact, for: .normal)
        numberbutton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        numberbutton.setTitleColor(.red, for: .normal)
        
        // Show or hide email button based on whether the contact is a teacher
        if isTeacher {
            emailbutton.isHidden = false
        } else {
            emailbutton.isHidden = true
        }
    }
    @IBOutlet weak var numberbutton: UIButton!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var emailbutton: UIButton!
}
