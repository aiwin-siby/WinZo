import UIKit

struct ClassSchedule {
    var period: Int
    var subject: String
    var teacher: String
    var time: String
}

struct Timetable {
    var day: String
    var classes: [ClassSchedule]
}

class timetableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var scroll: UIScrollView!
    
    var timetables: [Timetable] = []
    var selectedTimetable: Timetable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTimetableData()
        configureSegmentedControl()
        configureScrollView()
        addSwipeGestures()
        updateTimetableForSelectedDay()
    }
    
    func loadTimetableData() {
        timetables = [
            Timetable(day: "Monday", classes: [
                ClassSchedule(period: 1, subject: "Math", teacher: "Mr. John", time: "10:00 AM - 10:50 AM"),
                ClassSchedule(period: 2, subject: "Science", teacher: "Ms. Sarah", time: "11:00 AM - 11:50 AM"),
                ClassSchedule(period: 3, subject: "History", teacher: "Mr. Adam", time: "12:00 PM - 12:50 PM"),
                ClassSchedule(period: 4, subject: "English", teacher: "Ms. Emily", time: "1:00 PM - 1:50 PM"),
                ClassSchedule(period: 5, subject: "Physical Education", teacher: "Mr. Mike", time: "2:00 PM - 2:50 PM")
            ]),
            Timetable(day: "Tuesday", classes: [
                ClassSchedule(period: 1, subject: "Physics", teacher: "Dr. Smith", time: "10:00 AM - 10:50 AM"),
                ClassSchedule(period: 2, subject: "Chemistry", teacher: "Mr. Patel", time: "11:00 AM - 11:50 AM"),
                ClassSchedule(period: 3, subject: "Biology", teacher: "Ms. Clark", time: "12:00 PM - 12:50 PM"),
                ClassSchedule(period: 4, subject: "Math", teacher: "Mr. Taylor", time: "1:00 PM - 1:50 PM"),
                ClassSchedule(period: 5, subject: "Literature", teacher: "Ms. Green", time: "2:00 PM - 2:50 PM")
            ]),
            Timetable(day: "Wednesday", classes: [
                ClassSchedule(period: 1, subject: "Math", teacher: "Mr. John", time: "10:00 AM - 10:50 AM"),
                ClassSchedule(period: 2, subject: "Geography", teacher: "Mr. Lee", time: "11:00 AM - 11:50 AM"),
                ClassSchedule(period: 3, subject: "History", teacher: "Ms. Parker", time: "12:00 PM - 12:50 PM"),
                ClassSchedule(period: 4, subject: "Art", teacher: "Mr. Cooper", time: "1:00 PM - 1:50 PM"),
                ClassSchedule(period: 5, subject: "Music", teacher: "Ms. Williams", time: "2:00 PM - 2:50 PM")
            ]),
            Timetable(day: "Thursday", classes: [
                ClassSchedule(period: 1, subject: "Computer Science", teacher: "Mr. Scott", time: "10:00 AM - 10:50 AM"),
                ClassSchedule(period: 2, subject: "Math", teacher: "Mr. Harris", time: "11:00 AM - 11:50 AM"),
                ClassSchedule(period: 3, subject: "Biology", teacher: "Ms. Robinson", time: "12:00 PM - 12:50 PM"),
                ClassSchedule(period: 4, subject: "Chemistry", teacher: "Dr. White", time: "1:00 PM - 1:50 PM"),
                ClassSchedule(period: 5, subject: "History", teacher: "Mr. Green", time: "2:00 PM - 2:50 PM")
            ]),
            Timetable(day: "Friday", classes: [
                ClassSchedule(period: 1, subject: "Physics", teacher: "Ms. Williams", time: "10:00 AM - 10:50 AM"),
                ClassSchedule(period: 2, subject: "Chemistry", teacher: "Mr. Brown", time: "11:00 AM - 11:50 AM"),
                ClassSchedule(period: 3, subject: "Math", teacher: "Ms. Davis", time: "12:00 PM - 12:50 PM"),
                ClassSchedule(period: 4, subject: "Physical Education", teacher: "Mr. Taylor", time: "1:00 PM - 1:50 PM"),
                ClassSchedule(period: 5, subject: "English", teacher: "Ms. Thompson", time: "2:00 PM - 2:50 PM")
            ]
                     )]
    }
    
    private func configureSegmentedControl() {
        let daysOfWeek = timetables.map { $0.day }
        
        seg.removeAllSegments()
        for (index, day) in daysOfWeek.enumerated() {
            seg.insertSegment(withTitle: day, at: index, animated: false)
        }
        seg.selectedSegmentIndex = 0 // Default to the first day (Monday)
    }
    
    
    private func configureScrollView() {
        scroll.showsHorizontalScrollIndicator = false
        scroll.isScrollEnabled = true
        
        
        let screenWidth = UIScreen.main.bounds.width
        let segmentedControlWidth = screenWidth * 1.5
        
        
        scroll.contentSize = CGSize(width: segmentedControlWidth, height: scroll.frame.height)
        
        
        seg.frame = CGRect(x: 0, y: 0, width: segmentedControlWidth, height: scroll.frame.height)
        
        
        scroll.addSubview(seg)
    }
    
    
    private func addSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        scroll.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipe.direction = .right
        scroll.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        var currentOffset = scroll.contentOffset.x
        
        if gesture.direction == .left {
            if currentOffset + scroll.frame.width < scroll.contentSize.width {
                currentOffset += scroll.frame.width
            }
        } else if gesture.direction == .right {
            if currentOffset - scroll.frame.width >= 0 {
                currentOffset -= scroll.frame.width
            }
        }
        
        
        scroll.setContentOffset(CGPoint(x: currentOffset, y: 0), animated: true)
        
        
        let selectedIndex = Int(currentOffset / seg.frame.width)
        seg.selectedSegmentIndex = selectedIndex
        updateTimetableForSelectedDay() //
    }
    
    
    func updateTimetableForSelectedDay() {
        let selectedIndex = seg.selectedSegmentIndex
        selectedTimetable = timetables[selectedIndex]
        tableView.reloadData()
    }    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTimetable?.classes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! timetableTableViewCell
        
        if let classSchedule = selectedTimetable?.classes[indexPath.row] {
            cell.period.text = "\(classSchedule.period)"
            cell.teacher.text = "\(classSchedule.teacher)"
            cell.subject.text = "\(classSchedule.subject)"
            cell.time.text = "\(classSchedule.time)"
        }
        
        return cell
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        updateTimetableForSelectedDay()
    }
    
    
    @IBAction func back2(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

