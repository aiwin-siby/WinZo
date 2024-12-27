//
//  leaveapplyTableViewCell.swift
//  Aiwin project
//
//  Created by iroid on 20/11/24.
//

import UIKit

class leaveapplyTableViewCell: UITableViewCell {
    var onEdit: (() -> Void)?
       var onDelete: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBOutlet weak var durationTextField: UILabel!
    @IBOutlet weak var numberOfDaysTextField: UILabel!
    @IBOutlet weak var reasonforleave: UILabel!
    @IBOutlet weak var leavetype: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func handleDelete(_ sender: Any) {
        onDelete?()
    }
    
    @IBAction func handleEdit(_ sender: Any) {
        onEdit?()
    }
    
  
        

     
    
}
