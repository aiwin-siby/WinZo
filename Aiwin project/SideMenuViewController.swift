//
//  SideMenuViewController.swift
//  Aiwin project
//
//  Created by iroid on 05/12/24.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let menuItems = ["👤  Profile", "📅  Timetable", "📝  Leave", "📖  Diary", "☎️  Contact"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchDashboardData()
    }
    
    // MARK: - Table View DataSource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    // TableView Delegate - Handle item selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigationController = self.navigationController
        
        // Close the side menu
        self.dismiss(animated: true, completion: nil)
        
        // Navigate to the selected page
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyboard.instantiateViewController(withIdentifier: "profile")as! profileViewController
            self.navigationController?.pushViewController(vc1, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc2 = storyboard.instantiateViewController(withIdentifier: "timetable")as! timetableViewController
            self.navigationController?.pushViewController(vc2, animated: true)
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc3 = storyboard.instantiateViewController(withIdentifier: "leave")as! leaveViewController
            self.navigationController?.pushViewController(vc3, animated: true)
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc4 = storyboard.instantiateViewController(withIdentifier: "diary")as! diaryViewController
            self.navigationController?.pushViewController(vc4, animated: true)
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc5 = storyboard.instantiateViewController(withIdentifier: "contact")as! contactViewController
            self.navigationController?.pushViewController(vc5, animated: true)
        default:
            break
        }
    }
    func fetchDashboardData() {
        guard let token = UserDefaults.standard.string(forKey: "tvalue") else {
            print("Token not found")
            return
        }
        
        guard let url = URL(string: "https://jeetmeet.b4production.com/api/student/dashboard") else { return }
        
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
                   let student = jsonResponse["student"] as? [String: Any] {
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
        
        
        
        Namelabel.text = "\(firstName) \(lastName)"
        
        regno.text = "ID: \(studentData["reg_number"] as? String ?? "")"
        
    }
    @IBOutlet weak var Namelabel: UILabel!
    
    @IBOutlet weak var regno: UILabel!
    
}
