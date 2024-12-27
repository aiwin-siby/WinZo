//
//  profileViewController.swift
//  Aiwin project
//
//  Created by iroid on 22/11/24.
//

import UIKit

class profileViewController: UIViewController{
    var currentFirstName: String = ""
        var currentLastName: String = ""
        var studentId: String = "2"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regNumberLabel: UILabel!
    @IBOutlet weak var parentNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var rollNumberLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phone2Label: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var postCodeLabel: UILabel!
    @IBOutlet weak var bloodGroupLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudentDetails()
        picofstudent.layer.cornerRadius = picofstudent.frame.size.width / 2
        picofstudent.clipsToBounds = true
        // Do any additional setup after loading the view.
        applyShadowToView(profileview1)
        applyShadowToView(profileview2)
        applyShadowToView(profileview3)
        addProjectionEffectToView(profileview1)
        addProjectionEffectToView(profileview2)
        addProjectionEffectToView(profileview3)
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var profileview3: UIView!
    @IBOutlet weak var profileview2: UIView!
    @IBOutlet weak var profileview1: UIView!
    @IBOutlet weak var picofstudent: UIImageView!
    
    @IBAction func back10(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
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
    func fetchStudentDetails() {
        guard let token = UserDefaults.standard.string(forKey: "tvalue") else {
            print("Token not found")
            return
        }
        
        guard let url = URL(string: "https://jeetmeet.b4production.com/api/student/details") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Server error: \(httpResponse.statusCode)")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let student = jsonResponse["data"] as? [String: Any] {
                    DispatchQueue.main.async {
                        self.updateUI(with: student)
                    }
                } else {
                    print("Invalid response format")
                }
            } catch {
                print("Failed to parse response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    
    func updateUI(with studentData: [String: Any]) {
        let firstName = studentData["first_name"] as? String ?? ""
            let lastName = studentData["last_name"] as? String ?? ""
            
            currentFirstName = firstName  // Update currentFirstName
            currentLastName = lastName    // Update currentLastName
            
            print("currentFirstName: \(currentFirstName), currentLastName: \(currentLastName)")  // Debug line

            nameLabel.text = "Name: \(firstName) \(lastName)"
        
        regNumberLabel.text = "ID: \(studentData["reg_number"] as? String ?? "")"
        rollNumberLabel.text = "\(studentData["roll_number"] as? Int ?? 0)"
        classLabel.text = "\(studentData["class"] as? String ?? "")"
        divisionLabel.text = "\(studentData["division"] as? Int ?? 0)"
        dobLabel.text = "\(studentData["dob"] as? String ?? "")"
        phoneLabel.text = "\(studentData["phone"] as? String ?? "")"
        emailLabel.text = "\(studentData["email"] as? String ?? "")"
        phone2Label.text = "\(studentData["phone2"] as? String ?? "")"
        placeLabel.text = "\(studentData["place"] as? String ?? "")"
        postCodeLabel.text = "\(studentData["post"] as? String ?? "")"
        bloodGroupLabel.text = "\(studentData["blood"] as? String ?? "")"
        stateLabel.text = "\(studentData["state"] as? Int ?? 0)"
        countryLabel.text = "\(studentData["country"] as? Int ?? 0)"
        nationalityLabel.text = "\(studentData["nationality"] as? Int ?? 0)"
        genderLabel.text = "\(studentData["gender"] as? String ?? "")"
        
        if let stateId = studentData["state"] as? Int,
           let stateData = (studentData["states"] as? [[String: Any]])?.first(where: { $0["id"] as? Int == stateId }) {
            stateLabel.text = "State: \(stateData["name"] as? String ?? "Unknown")"
        }
        if let parent = studentData["parents"] as? [String: Any],
           let parentFirstName = parent["first_name"] as? String,
           let parentLastName = parent["last_name"] as? String {
            parentNameLabel.text = "\(parentFirstName) \(parentLastName)"
        } else {
            parentNameLabel.text = "Parent Name Not Available"
        }
        if let countryId = studentData["country"] as? Int,
           let countryData = (studentData["countries"] as? [[String: Any]])?.first(where: { $0["id"] as? Int == countryId }) {
            countryLabel.text = "Country: \(countryData["name"] as? String ?? "Unknown")"
        }
        
        if let nationalityId = studentData["nationality"] as? Int,
           let nationalityData = (studentData["nationalities"] as? [[String: Any]])?.first(where: { $0["id"] as? Int == nationalityId }) {
            nationalityLabel.text = "Nationality: \(nationalityData["name"] as? String ?? "Unknown")"
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        print("Edit Button Pressed")  // Debugging line
        presentEditNameAlert()
    }
    func presentEditNameAlert() {
     
            
            let alertController = UIAlertController(title: "Edit Name", message: "Enter the new first and last name", preferredStyle: .alert)
            
            alertController.addTextField { textField in
                textField.text = self.currentFirstName
                textField.placeholder = "First Name"
            }
            
            alertController.addTextField { textField in
                textField.text = self.currentLastName
                textField.placeholder = "Last Name"
            }

            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let newFirstName = alertController.textFields?[0].text, !newFirstName.isEmpty,
                      let newLastName = alertController.textFields?[1].text, !newLastName.isEmpty else {
                    self.showError("Please enter both first and last name.")
                    return
                }
                
          
                self.updateStudentName(firstName: newFirstName, lastName: newLastName, studentId: self.studentId) { success, message in
                    if success {
                        // If successful, update the UI with the new name
                        DispatchQueue.main.async {
                            self.nameLabel.text = "Name: \(newFirstName) \(newLastName)"
                            self.currentFirstName = newFirstName
                            self.currentLastName = newLastName
                        }
                    } else {
                        // Show error if the update failed
                        DispatchQueue.main.async {
                            self.showError(message)
                        }
                    }
                }
            }
            
            // Add a "Cancel" button to dismiss the alert
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            // Present the alert
            self.present(alertController, animated: true, completion: nil)
        }
        
        // Show error message in alert
        func showError(_ message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        // Function to update student's name using the new API
        func updateStudentName(firstName: String, lastName: String, studentId: String, completion: @escaping (Bool, String) -> Void) {
            guard let token = UserDefaults.standard.string(forKey: "tvalue") else {
                print("Token not found")
                return
            }
            let url = URL(string: "https://jeetmeet.b4production.com/api/student/profile/edit_name")! // API endpoint
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            // Request parameters
            let parameters: [String: Any] = [
                "id": studentId,
                "first_name": firstName,
                "last_name": lastName
            ]
            
            // Convert parameters to JSON
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Send the request
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(false, "Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let data = data else {
                        completion(false, "No data received")
                        return
                    }
                    
                    // Parse the response
                    do {
                        if let responseData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let status = responseData["status"] as? Int, status == 1 {
                            completion(true, "Name updated successfully")
                        } else {
                            completion(false, "Failed to update name")
                        }
                    } catch {
                        completion(false, "Failed to parse response")
                    }
                }
                
                task.resume()
            } catch {
                completion(false, "Error encoding parameters")
            }
        }
}
    
 
    
    

