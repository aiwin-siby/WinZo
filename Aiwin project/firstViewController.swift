//
//  firstViewController.swift
//  Aiwin project
//
//  Created by iroid on 19/11/24.
//

import UIKit

class firstViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var changingimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Get Started", for: .normal)
    }
    

    @IBAction func button(_ sender: Any) {
        swipeImageAnimation()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage = storyboard.instantiateViewController(withIdentifier: "login")as! ViewController
        self.navigationController?.pushViewController(nextpage, animated: true)
    }
            
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func swipeImageAnimation() {
         

       
         UIView.animate(withDuration: 0.5, animations: {
             self.changingimage.frame.origin.x = -self.view.frame.size.width
         })

         }

         // Change button title after the image swap animation
        
     
   
}
