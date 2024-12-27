//
//  ViewController.swift
//  Aiwin project
//
//  Created by iroid on 13/11/24.
//

import UIKit
import SkyFloatingLabelTextField
var eyeButton: UIButton!
class ViewController: UIViewController, UINavigationBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        errorMessageLabel.isHidden = true
        loginbutton.layer.cornerRadius = 5
        loginbutton.clipsToBounds = true
        loginbutton.layer.shadowColor = UIColor.black.cgColor
        loginbutton.layer.shadowOpacity = 0.3
        loginbutton.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginbutton.layer.shadowRadius = 5
        username.tintColor = .black
        
        username.textColor = .black
        
        username.lineColor = .gray
        
        username.selectedTitleColor = .black
        
        username.selectedLineColor = .black
        
        username.font = UIFont.systemFont(ofSize: 14)
        
        username.titleFont = UIFont.systemFont(ofSize: 12)
        
        username.placeholderFont = UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        username.title = "Usename/email"
        username.placeholder = "Enter Username/Email"
        password.placeholder = "Enter Your Password "
        
        password.title = "Password"
        
        password.tintColor = .black
        
        password.textColor = .black
        
        password.lineColor = .gray
        
        password.selectedTitleColor = .black
        
        password.selectedLineColor = .black
        
        password.font = UIFont.systemFont(ofSize: 14)
        
        password.titleFont = UIFont.systemFont(ofSize: 12)
        
        password.placeholderFont = UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        
        password.isSecureTextEntry = true
        addEyeButton()
        applyShadowToView(view3)
        addProjectionEffectToView(view3)
    }
    
    @IBAction func forgetpassword(_ sender: Any) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newview = storyboard.instantiateViewController(withIdentifier: "forgetpassword")as! forgetpasswordViewController
       self.navigationController?.pushViewController(newview, animated: true)
    }
    @IBOutlet weak var username: SkyFloatingLabelTextField!
    
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    func addEyeButton() {
        eyeButton = UIButton(type: .custom)
        let eyeIcon = UIImage(systemName: "eye.fill")
        eyeButton.setImage(eyeIcon, for: .normal)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        password.rightView = eyeButton
        password.rightViewMode = .always
    }
    
    @objc func togglePasswordVisibility() {
        
        password.isSecureTextEntry.toggle()
        let eyeIcon = password.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        eyeButton.setImage(eyeIcon, for: .normal)
    }
    
    @IBAction func loginbutton(_ sender: Any){
        guard let usernameText = username.text, !usernameText.isEmpty,
              let passwordText = password.text, !passwordText.isEmpty else {
            showErrorMessage("Please enter both username and password.")
            return
        }

        loginbutton.isEnabled = false
        loginbutton.setTitle("Logging in...", for: .normal)

        let loginData = ["username": usernameText, "password": passwordText]

        loginUser(with: loginData)
    }


    func loginUser(with data: [String: String]){
        guard let url = URL(string: "https://jeetmeet.b4production.com/api/student/login") else {
            showErrorMessage("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = jsonData
        } catch {
            showErrorMessage("Error encoding data.")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.loginbutton.isEnabled = true
                self.loginbutton.setTitle("Login", for: .normal)
                
                if let error = error {
                    self.showErrorMessage("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    self.showErrorMessage("No data received.")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    self.showErrorMessage("Server returned an error: \(httpResponse.statusCode)")
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let responseDict = jsonResponse as? [String: Any] {
                        if let status = responseDict["status"] as? Int, status == 1,
                           let token = responseDict["message"] as? String {
                            print("Login successful. Token: \(token)")
                            UserDefaults.standard.set(token, forKey: "tvalue")
                            
                            DispatchQueue.main.async {
 
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               let nextpage = storyboard.instantiateViewController(withIdentifier: "new") as? newViewController
                                self.navigationController?.pushViewController(nextpage!, animated: true)


                            }
                        } else {
                            let errorMessage = responseDict["message"] as? String ?? "Invalid response from server."
                            self.showErrorMessage(errorMessage)
                        }
                    } else {
                        self.showErrorMessage("Invalid response format.")
                    }
                } catch {
                    self.showErrorMessage("Error parsing response.")
                }
            }
        }.resume()
    }

    

        // Function to show error message
        func showErrorMessage(_ message: String) {
            errorMessageLabel.text = message
            errorMessageLabel.isHidden = false
        }

func navigateToDashboard() {
            if let dashboardVC = storyboard?.instantiateViewController(withIdentifier: "newViewController") {
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(dashboardVC, animated: true)
                } else {
                    print("Navigation controller is not set")
                }
            }
        }

        func redirectToDashboard() {
          
            if let dashboardVC = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") {
                navigationController?.pushViewController(dashboardVC, animated: true)
            }
        }
    
      
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var loginbutton: UIButton!
    func applyShadowToView(_ view: UIView) {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.3
            view.layer.shadowOffset = CGSize(width: 4, height: 4)
            view.layer.shadowRadius = 8
        }

        func addProjectionEffectToView(_ view: UIView) {
          
            view.layer.transform = CATransform3DMakeTranslation(0, 0, 10)
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = false
        }
}

