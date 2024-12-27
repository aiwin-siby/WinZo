//
//  newViewController.swift
//  Aiwin project
//
//  Created by iroid on 15/11/24.
//
import SideMenu
import UIKit



var notificationdate = ["Dated: September 10, 2025", "Dated: April 10, 2025", "Dated: November 5, 2024", "Dated: May 20, 2024", "Dated: January 15, 2024"]

var notificationheading = ["Programming contest","Parents meeting","College day","College election","Arts festival"]
var notificationdiscription = ["The Programming Contest is set to take place on February 15, 2024, where the most skilled coders in the school will compete in an intense battle of logic and speed. This year's theme is Coding for a Cause, with challenges designed to test not just technical skills but also the ability to create software solutions for social good. Competitors will have four hours to solve algorithmic puzzles and create a functioning project. With cash prizes and internship opportunities on the line, the event attracts not only students but also industry professionals who come to scout talent. Fun fact: The contest will also feature a debugging station where students can get real-time feedback on their coding errors!","Scheduled for March 10, 2024, the Parents Meeting is an essential event for discussing academic progress and school activities. It gives parents a chance to meet teachers face-to-face, hear about their child's performance, and provide feedback. This year, the meeting will also include an interactive session on Digital Learning Tools, where teachers will introduce new apps and platforms that help students learn better at home. A highlight of the meeting will be the Future of Education talk, featuring a guest speaker who will discuss the role of technology in modern classrooms. Interesting factor: Every parent will receive a customized report on their child’s strengths and areas for improvement.","College Day, happening on April 25, 2024, is one of the most anticipated events of the year! It’s a day to celebrate school spirit with a variety of activities. The event kicks off with a grand parade featuring decorated floats and performances from the school bands, followed by a talent show where students showcase their hidden talents—from singing and dancing to stand-up comedy and magic tricks. The highlight is the Best Dressed Competition, where students dress according to a fun theme, like Retro School Days or Futuristic Fashion. Fun fact: The school mascot will make a surprise appearance, challenging students to a series of friendly games throughout the day!","The College Election will take place on October 12, 2024, offering students a chance to vote for their peers in key student government positions. This year, the election will be more interactive than ever with a Live Debate Night hosted a week before the voting day. Candidates will present their manifestos in front of the student body, followed by a Q&A session where students can grill them on their policies. Voting will be done via a new digital platform designed to make the process faster and more secure. Interesting factor: The election results will be streamed live on social media, with a countdown clock and live updates throughout the day. The winning candidate for president will also get the honor of hosting the upcoming school dance!","The Arts Festival will be held over three days from May 5-7, 2024, and it’s the event where creativity takes center stage! The festival will include art exhibits featuring student paintings, sculptures, and photography, along with a full schedule of live performances such as plays, musical concerts, and dance routines. This year’s theme is Innovation and Tradition, so students will explore ways to blend classical art forms with modern techniques. The festival will also have an Open Art Lounge, where students and faculty can collaborate on murals and graffiti art. Interesting factor: A student-designed virtual gallery will be launched alongside the physical exhibition, allowing the school community to experience the art from anywhere. Plus, all performances will be recorded and uploaded to the school’s YouTube channel!"]

class newViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UINavigationBarDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var parentImage: UIImageView!
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var rollNumber: UILabel!
    
    @IBOutlet weak var registernumber: UILabel!
    @IBOutlet weak var Studentname: UILabel!
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationheading.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "hometable")as! homeTableViewCell
        tcell.heading2.text = notificationheading[indexPath.row]
        tcell.heading1.text = notificationdate[indexPath.row]
        tcell.heading3.text = notificationdiscription[indexPath.row]
        return tcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newview = storyboard.instantiateViewController(withIdentifier: "notification")as! notificationViewController
        newview.recieveddate = String(notificationdate[indexPath.row])
        newview.recievedheading = String(notificationheading[indexPath.row])
        newview.recieveddiscriprion = String(notificationdiscription[indexPath.row])
        self.navigationController?.pushViewController(newview, animated: true)
    }
    
    @IBOutlet weak var view5: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDashboardData()
        roundBottomCorners(for: view5, radius: 200)
        self.navigationItem.hidesBackButton = true
        addProjectionEffectToView(view5)
        applyShadowToView(view5)
        addBorderToImageView(imageView: profileImage, borderColor: UIColor(red: 0.0, green: 74.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0), borderWidth: 1)
        addBorderToImageView(imageView: parentImage, borderColor: UIColor(red: 0.0, green: 74.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0), borderWidth: 1)
    }
    
    
    func roundBottomCorners(for view: UIView, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    func addBorderToImageView(imageView: UIImageView, borderColor: UIColor, borderWidth: CGFloat) {
        
        imageView.layer.borderColor = borderColor.cgColor
        
        imageView.layer.borderWidth = borderWidth
        
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2  //
        imageView.layer.masksToBounds = true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
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
        
        // MARK: - UI Update Methods
        func updateUI(with student: [String: Any]) {
            
            rollNumber.text = "Roll No: \(student["roll_number"] as? Int ?? 0)"
            studentClass.text = "Class: \(student["class"] as? String ?? "")"
            division.text = "Division: \(student["division"] as? Int ?? 0)"
            dateOfBirth.text = "DOB: \(student["dob"] as? String ?? "")"
            Studentname.text = "\(student["first_name"] as? String ?? "") \(student["last_name"] as? String ?? "")"
           
              registernumber.text = "ID:  \(student["reg_number"] as? String ?? "")"// Adjust key based on actual API response
            if let parent = student["parents"] as? [String: Any],
               let parentFirstName = parent["first_name"] as? String,
               let parentLastName = parent["last_name"] as? String {
                // Combine the first and last name to show full name
                parentName.text = "\(parentFirstName) \(parentLastName)"
            } else {
                // If no parent data exists, show a default message
                parentName.text = "Parent Name Not Available"
            }
            if let profileImageUrl = student["profile_image_url"] as? String {
                loadImage(from: profileImageUrl, into: profileImage)
            } else {
                profileImage.image = UIImage(named: "Mbappe")
            }
            
            if let parentImageUrl = (student["parents"] as? [String: Any])?["image_url"] as? String {
                loadImage(from: parentImageUrl, into: parentImage)
            } else {
                parentImage.image = UIImage(named: "Mbappe")
            }
        }
    func loadImage(from urlString: String, into imageView: UIImageView) {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                } else {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "Mbappe")
                    }
                }
            }.resume()
        }
        

}

    
    

