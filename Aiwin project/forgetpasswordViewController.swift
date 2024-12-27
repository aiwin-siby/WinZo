//
//  forgetpasswordViewController.swift
//  Aiwin project
//
//  Created by iroid on 14/11/24.
//

import UIKit

class forgetpasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        submitbutton.layer.cornerRadius = 5
        submitbutton.clipsToBounds = true
        submitbutton.layer.shadowColor = UIColor.black.cgColor
        submitbutton.layer.shadowOpacity = 0.3
        submitbutton.layer.shadowOffset = CGSize(width: 0, height: 5)
        submitbutton.layer.shadowRadius = 5
        successlabel.isHidden = true
    }
    
    @IBOutlet weak var submitbutton: UIButton!
    
    @IBOutlet weak var successlabel: UILabel!
    @IBAction func submitbutton(_ sender: Any) {
        successlabel.isHidden = false
                successlabel.text = "⚠️ A password reset link has been sent to your email. Please return to your homepage!"
        
        UIView.animate(withDuration: 5) {
                    self.successlabel.alpha = 1.0
                }
             
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.successlabel.isHidden = true
                    self.successlabel.alpha = 0.0
                }
            }
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
}

