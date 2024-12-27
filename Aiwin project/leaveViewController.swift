//
//  leaveViewController.swift
//  Aiwin project
//
//  Created by iroid on 20/11/24.
//

import UIKit


var typeleave = ["Casual", "Annual leave", "Onam", "Christmas"]
var leavedays = ["7", "5", "10", "10"]

class leaveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    struct LeaveApplication {
        var leaveType: String
        var reason: String
        var durationText: String
        var numberOfDays: String
    }
    var leaveApplications: [LeaveApplication] = []
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leavePopupView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        
        startTimePicker.datePickerMode = .time
        endTimePicker.datePickerMode = .time
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        
    }
    
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? leavedays.count : leaveApplications.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            // For assigned leave
            if let pcell = tableView.dequeueReusableCell(withIdentifier: "assignedleave", for: indexPath) as? assignedleaveTableViewCell {
                pcell.days.text = leavedays[indexPath.row]
                pcell.leavetype.text = typeleave[indexPath.row]
                cell = pcell
            } else {
                cell = UITableViewCell()
            }
        } else {
            // For leave applications
            if let kcell = tableView.dequeueReusableCell(withIdentifier: "leaveapplication", for: indexPath) as? leaveapplyTableViewCell {
                if leaveApplications.count > indexPath.row {
                    let application = leaveApplications[indexPath.row]
                    kcell.leavetype.text = application.leaveType
                    kcell.reasonforleave.text = application.reason
                    kcell.durationTextField.text = application.durationText
                    kcell.numberOfDaysTextField.text = application.numberOfDays
                    kcell.layer.borderWidth = 1.0
                    kcell.layer.borderColor = UIColor.black.cgColor
                    kcell.layer.cornerRadius = 8.0
                    kcell.layer.shadowColor = UIColor.black.cgColor
                    kcell.layer.shadowOffset = CGSize(width: 0, height: 2)
                    kcell.layer.shadowOpacity = 0.3
                    kcell.layer.shadowRadius = 4.0
                    kcell.layer.masksToBounds = false
                    
                    // Set up the edit and delete actions
                    kcell.onEdit = { [weak self] in
                        self?.editLeaveApplication(at: indexPath)
                    }
                    kcell.onDelete = { [weak self] in
                        self?.deleteLeaveApplication(at: indexPath)
                    }
                    
                    cell = kcell
                } else {
                    cell = UITableViewCell()
                    cell.textLabel?.text = "No leave applications"
                }
            } else {
                cell = UITableViewCell()
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{ if segmentedControl.selectedSegmentIndex == 0 {
        
        return 100
    } else {
        
        return 250
    }
    }
    @objc func showLeaveApplicationPopup() {
        leavePopupView.backgroundColor = .white
        leavePopupView.layer.cornerRadius = 10
        leavePopupView.layer.shadowColor = UIColor.black.cgColor
        leavePopupView.layer.shadowOpacity = 0.2
        leavePopupView.layer.shadowOffset = CGSize(width: 0, height: 5)
        leavePopupView.layer.shadowRadius = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "Leave Application"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.frame = CGRect(x: 20, y: 20, width: leavePopupView.frame.width - 40, height: 30)
        leavePopupView.addSubview(titleLabel)
        
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        leavePopupView.addSubview(submitButton)
        
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        leavePopupView.addSubview(cancelButton)
        
        self.view.addSubview(leavePopupView)
    }
    func editLeaveApplication(at indexPath: IndexPath) {
        let application = leaveApplications[indexPath.row]
        
        leavetype.text = application.leaveType
        reasontextfield.text = application.reason
        
        leavePopupView.isHidden = false
        
        submitButton.removeTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        submitButton.tag = indexPath.row
    }
    
    @objc func handleUpdate() {
        guard let leaveType = leavetype.text, !leaveType.isEmpty,
              let reason = reasontextfield.text, !reason.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        let startTime = startTimePicker.date
        let endTime = endTimePicker.date
        
        let startDateTime = combineDateAndTime(date: startDate, time: startTime)
        let endDateTime = combineDateAndTime(date: endDate, time: endTime)
        
        // Format the dates in the desired format
        let formattedDuration = formatDuration(from: startDate, to: endDate)
        
        // Update the leave application
        let updatedLeaveApplication = LeaveApplication(
            leaveType: leaveType,
            reason: reason,
            durationText: formattedDuration,
            numberOfDays: "\(calculateNumberOfDays(from: startDate, to: endDate))"
        )
        
        // Get the index of the leave application to update
        let index = submitButton.tag
        leaveApplications[index] = updatedLeaveApplication
        
        tableView.reloadData()
        
        leavePopupView.isHidden = true
    }
    
    func deleteLeaveApplication(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Leave Application", message: "Are you sure you want to delete this leave application?", preferredStyle: .alert)
        
        // Cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Delete action
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            // Remove the application from the leaveApplications array
            self.leaveApplications.remove(at: indexPath.row)
            
            // Reload the table view to reflect the changes
            self.tableView.reloadData()
        }))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    @objc func handleSubmit() {
        guard let leaveType = leavetype.text, !leaveType.isEmpty,
              let reason = reasontextfield.text, !reason.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        let startTime = startTimePicker.date
        let endTime = endTimePicker.date
        
        let startDateTime = combineDateAndTime(date: startDate, time: startTime)
        let endDateTime = combineDateAndTime(date: endDate, time: endTime)
        
        // Format the dates in the desired format
        let formattedDuration = formatDuration(from: startDate, to: endDate)
        
        // Create a new leave application
        let newLeaveApplication = LeaveApplication(
            leaveType: leaveType,
            reason: reason,
            durationText: formattedDuration,
            numberOfDays: "\(calculateNumberOfDays(from: startDate, to: endDate))"
        )
        
        leaveApplications.append(newLeaveApplication)
        tableView.reloadData()
        
        leavePopupView.isHidden = true
    }
    func calculateNumberOfDays(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
    func formatDuration(from startDate: Date, to endDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long  // This will format the date as "11 November 2024"
        formatter.timeStyle = .none
        
        let startFormatted = formatter.string(from: startDate)
        let endFormatted = formatter.string(from: endDate)
        
        return  "\(startFormatted)\n to\n\(endFormatted)"
    }
    
    let leaveTypes = ["Casual", "Annual", "Onam", "Christmas"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    @objc func handleCancel() {
        
        leavePopupView.isHidden = true
    }
    @IBAction func leaveapplybtn(_ sender: Any) {
        leavePopupView.isHidden = false
        showLeaveApplicationPopup()
    }
    @IBOutlet weak var leavePopupView: UIView!
    
    @IBOutlet var reasonTextField: [UITextField]!
    
    @IBOutlet weak var reasontextfield: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var leavetype: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents) ?? Date()
    }
    
    func calculateDuration(from startDate: Date, to endDate: Date) -> (text: String, numberOfDays: String) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        let durationText = "\(days) days, \(hours) hours, \(minutes) minutes"
        return (text: durationText, numberOfDays: "\(days)")
    }
    
    @IBAction func back7(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}






