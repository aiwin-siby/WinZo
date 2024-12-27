//
//  notificationViewController.swift
//  Aiwin project
//
//  Created by iroid on 19/11/24.
//

import UIKit

class notificationViewController: UIViewController {
    
    var recieveddate : String?
    var recievedheading : String?
    var recieveddiscriprion: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        discription.text = recieveddiscriprion
        date.text = recieveddate
        heading.text = recievedheading
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var heading: UILabel!
    
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
