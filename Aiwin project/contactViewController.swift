//
//  contactViewController.swift
//  Aiwin project
//
//  Created by iroid on 04/12/24.
//

import UIKit

class contactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // Dummy Data for Emergency Contacts
    var emergencyContacts: [(name: String, contact: String)] = [
        ("Centralized Helpline", "112"),
        ("Police", "100"),
        ("Fire Station", "101"),
        ("Ambulance", "108"),
        ("Women Helpline", "1091"),
        ("Women Helpline (Alternate)", "181")
    ]
    
    // Dummy Data for Teachers with Subjects
    var teachers: [(name: String, subject: String, email: String, contact: String)] = [
        ("Mr. Thomas", "Math", "mrthomas@school.com", "555-1111"),
        ("Ms. Clark", "English", "msclark@school.com", "555-2222"),
        ("Mrs. Adams", "Science", "mrsadams@school.com", "555-3333"),
        ("Mr. Baker", "History", "mrbaker@school.com", "555-4444")
    ]
    
    // This will determine which data set to display
    var currentData: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial data to be emergency contacts
        currentData = emergencyContacts.map { ($0.name, $0.contact) }
        
        // Set up the table view and segmented control
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as! contactTableViewCell
        
        let contact = currentData[indexPath.row]
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            cell.configureCell(name: contact.0, contact: contact.1, isTeacher: false)
        } else {
            // Teachers: Display name, subject, email, and phone number
            let teacher = teachers[indexPath.row]
            cell.configureCell(name: teacher.name, contact: teacher.contact, isTeacher: false)
        }
        
        // Handle number button tap (for calling)
        cell.numberbutton.addTarget(self, action: #selector(handleCallTap(_:)), for: .touchUpInside)
        
        // Handle email button tap (for emailing)
        cell.emailbutton.addTarget(self, action: #selector(handleEmailTap(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        135
    }
    
    // MARK: - Segmented Control Action
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // Emergency Contacts
            currentData = emergencyContacts.map { ($0.name, $0.contact) }
        } else {
            // Teachers with Subject and Contact Info
            currentData = teachers.map { ($0.name, "\($0.subject) - \($0.email), \($0.contact)") }
        }
        
        // Reload the table view with the new data
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func handleCallTap(_ sender: UIButton) {
        guard let phoneNumber = sender.title(for: .normal) else { return }
        
        let alert = UIAlertController(title: "Call \(phoneNumber)?", message: "Do you want to call this number?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            if let url = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(url)
            }
        }))
        
        present(alert, animated: true)
    }
    
    @objc func handleEmailTap(_ sender: UIButton) {
        guard let email = sender.title(for: .normal) else { return }
        
        let alert = UIAlertController(title: "Email \(email)?", message: "Do you want to send an email to this address?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        }))
        
        present(alert, animated: true)
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func back7(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
