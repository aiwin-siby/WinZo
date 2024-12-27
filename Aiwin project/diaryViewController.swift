//
//  diaryViewController.swift
//  Aiwin project
//
//  Created by iroid on 20/11/24.
//

import UIKit
class DiaryEntry {
    var heading: String
    var date: Date
    var description: String
    
    init(heading: String, date: Date, description: String) {
        self.heading = heading
        self.date = date
        self.description = description
    }
}

class diaryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    var diaryEntries = [DiaryEntry]()
        var selectedIndexPath: IndexPath?
        

        var popupView: UIView!
        var headingTextField: UITextField!
        var datePicker: UIDatePicker!
        var descriptionTextView: UITextView!
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        view.backgroundColor = .white
                
           
        
                setupPopupView()
            }
            
            func setupPopupView() {
                popupView = UIView(frame: CGRect(x: 33, y: 149, width: 327, height: 600))
                popupView.backgroundColor = .white
                popupView.layer.cornerRadius = 10
                popupView.isHidden = true
                view.addSubview(popupView)
                

                headingTextField = UITextField(frame: CGRect(x: 20, y: 30, width: 260, height: 40))
                headingTextField.placeholder = "Enter heading"
                headingTextField.borderStyle = .roundedRect
                popupView.addSubview(headingTextField)
                
                // Date Picker
                datePicker = UIDatePicker(frame: CGRect(x: 20, y: 80, width: 260, height: 100))
                datePicker.datePickerMode = .date
                popupView.addSubview(datePicker)
            
                descriptionTextView = UITextView(frame: CGRect(x: 20, y: 200, width: 260, height: 100))
                descriptionTextView.layer.borderColor = UIColor.gray.cgColor
                descriptionTextView.layer.borderWidth = 1
                descriptionTextView.layer.cornerRadius = 5
                popupView.addSubview(descriptionTextView)
                
                // Save Button
                let saveButton = UIButton(frame: CGRect(x: 100, y: 320, width: 100, height: 40))
                saveButton.setTitle("Save", for: .normal)
                saveButton.backgroundColor = .green
                saveButton.addTarget(self, action: #selector(saveDiaryEntry), for: .touchUpInside)
                popupView.addSubview(saveButton)
                
                // Cancel Button
                let cancelButton = UIButton(frame: CGRect(x: 100, y: 370, width: 100, height: 40))
                cancelButton.setTitle("Cancel", for: .normal)
                cancelButton.backgroundColor = .red
                cancelButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
                popupView.addSubview(cancelButton)
            }
            
            @objc func showPopup() {
                popupView.isHidden = false
                popupView.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self.popupView.alpha = 1
                }
            }
            
            @objc func closePopup() {
                UIView.animate(withDuration: 0.3, animations: {
                    self.popupView.alpha = 0
                }) { _ in
                    self.popupView.isHidden = true
                }
            }
            
            @objc func saveDiaryEntry() {
                guard let heading = headingTextField.text, !heading.isEmpty,
                      let description = descriptionTextView.text, !description.isEmpty else {
                    return
                }
                
                let newDiaryEntry = DiaryEntry(heading: heading, date: datePicker.date, description: description)
                
                if let selectedIndexPath = selectedIndexPath {
         
                    diaryEntries[selectedIndexPath.row] = newDiaryEntry
                } else {
                 
                    diaryEntries.append(newDiaryEntry)
                }
                
                tableView.reloadData()
                closePopup()
            }
            
            // MARK: - UITableView DataSource
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return diaryEntries.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let tcell = tableView.dequeueReusableCell(withIdentifier: "diary")as! diaryTableViewCell
                
                let entry = diaryEntries[indexPath.row]
                let formattedDate = formatDateAndMonth(entry.date)
                tcell.layer.borderWidth = 1.0
                    tcell.layer.borderColor = UIColor.black.cgColor
                    tcell.layer.cornerRadius = 8.0
                    tcell.layer.shadowColor = UIColor.black.cgColor
                    tcell.layer.shadowOffset = CGSize(width: 0, height: 2)
                    tcell.layer.shadowOpacity = 0.3
                    tcell.layer.shadowRadius = 4.0
                    tcell.layer.masksToBounds = false
                tcell.diarydate.text = "Date:\(formattedDate)"
                tcell.diaryheading.text = entry.heading
    
                tcell.editbtn.tag = indexPath.row
                
                tcell.editbtn.addTarget(self, action: #selector(editDiaryEntry(_:)), for: .touchUpInside)
                tcell.numberbtn.setTitle("\(diaryEntries.count)", for: .normal)
                
                
                tcell.deletebtn.tag = indexPath.row
                tcell.deletebtn.addTarget(self, action: #selector(deleteDiaryEntry(_:)), for: .touchUpInside)
              
                
                return tcell
            }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
            // MARK: - UITableView Delegate
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let entry = diaryEntries[indexPath.row]
                
                headingTextField.text = entry.heading
                datePicker.date = entry.date
                descriptionTextView.text = entry.description
                
                selectedIndexPath = indexPath
                showPopup()
            }
            
            // MARK: - Edit and Delete Actions
            
            @objc func editDiaryEntry(_ sender: UIButton) {
                let indexPath = IndexPath(row: sender.tag, section: 0)
                let entry = diaryEntries[indexPath.row]
                
                headingTextField.text = entry.heading
                datePicker.date = entry.date
                descriptionTextView.text = entry.description
                
                selectedIndexPath = indexPath
                showPopup()
            }
            
            @objc func deleteDiaryEntry(_ sender: UIButton) {
                let indexPath = IndexPath(row: sender.tag, section: 0)
                
                diaryEntries.remove(at: indexPath.row)
                
               
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
    
    @IBAction func popupview(_ sender: Any) {
        showPopup()
    }
    
    @IBOutlet weak var tableView: UITableView!
    func formatDateAndMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "MMMM dd"
        let monthAndDay = dateFormatter.string(from: date)
        
      
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        

        return "\(monthAndDay), \(year)"
    }
    
    
    @IBAction func back5(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
        }
