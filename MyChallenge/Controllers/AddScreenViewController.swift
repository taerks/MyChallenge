//
//  AddScreenViewController.swift
//  goal2.0
//
//  Created by Антон Ермолов on 13.08.2021.
//

import UIKit
import RealmSwift

final class AddScreenViewController: UIViewController {
    
    //MARK: - variables
    let realm = try! Realm()
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    
    // MARK: - Outlets
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    @IBOutlet weak var step1TextField: UITextField!
    @IBOutlet weak var step2TextField: UITextField!
    @IBOutlet weak var step3TextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    // MARK: - IBActions
    @IBAction private func textChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataPicker(dataPicker: datePicker)
        createToolbar(toolbar: toolbar)
        
        updateSaveButtonState()
    }
    
    //MARK: - UI
    private func createDataPicker(dataPicker: UIDatePicker) {
        deadlineTextField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        let localID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localID!)
        datePicker.minimumDate = Date()
    }
    
    private func createToolbar(toolbar: UIToolbar) {
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        deadlineTextField.inputAccessoryView = toolbar
    }
    //MARK: - selector for toolbar
    @objc private func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        deadlineTextField.text = formatter.string(from: datePicker.date)
        
        view.endEditing(true)
    }
    //MARK: - functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func updateSaveButtonState() {
        guard let countTF = countTextField.text,
              let unitTF = unitTextField.text,
              let deadlineTF = deadlineTextField.text,
              let step1TF = step1TextField.text,
              let step2TF = step2TextField.text,
              let step3TF = step3TextField.text
        else {return}
        
        saveButton.isEnabled = !countTF.isEmpty &&
            !unitTF.isEmpty &&
            !deadlineTF.isEmpty &&
            !step1TF.isEmpty &&
            !step2TF.isEmpty &&
            !step3TF.isEmpty
    }
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        guard let count = countTextField.text,
              let units = unitTextField.text,
              let deadline = deadlineTextField.text,
              let step1 = step1TextField.text,
              let step2 = step2TextField.text,
              let step3 = step3TextField.text
        else {return}
        
        let newGoal = MainGoal(fact: 0,
                               plan: Int(count)!,
                               units: units,
                               deadline: deadline,
                               step1: Int(step1)!,
                               step2: Int(step2)!,
                               step3: Int(step3)!)
        try! realm.write {
            realm.add(newGoal)
        }
    }
    
}
