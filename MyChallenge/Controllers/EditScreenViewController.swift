//
//  EditScreenViewController.swift
//  goal2.0
//
//  Created by Антон Ермолов on 06.09.2021.
//

import UIKit
import RealmSwift

final class EditScreenViewController: UIViewController {
    
    //MARK: - variables
    var goals: Results<MainGoal>!
    let realm = try! Realm()
    var goal: MainGoal!
    
    //MARK: - outlets
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var step1Button: UIButton!
    @IBOutlet weak var step2Button: UIButton!
    @IBOutlet weak var step3Button: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        goals = realm.objects(MainGoal.self)
        
        createBackground()
        setUItext()
        setProgressView(progressView: progressView)
        swipe()
    }
    
    private func swipe() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    //MARK: - UI
    private func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "EditScreenBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        self.view.backgroundColor = UIColor.clear
    }
    
    private func setUItext() {
        planLabel.text = "\(String(goal.fact)) / \(String(goal.plan))  \(goal.units)"
        deadlineLabel.text = "till \(goal.deadline)"
        step1Button.setTitle("+\(String(goal.step1))", for: .normal)
        step2Button.setTitle("+\(String(goal.step2))", for: .normal)
        step3Button.setTitle("+\(String(goal.step3))", for: .normal)
    }
    
    private func setProgressView(progressView: UIProgressView) {
        progressView.progress = Float(goal.fact) / Float(goal.plan)
    }
    
    private func showDeleteAlert() {
        let deleteAlert = UIAlertController(title: "Delete", message: "delete goal?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            UIAlertAction in
            self.performSegue(withIdentifier: "deleteSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func plus1Button(_ sender: UIButton) {
        try! realm.write {
            goal.fact += goal.step1
            planLabel.text =  "\(String(goal.fact)) / \(String(goal.plan))  \(goal.units)"
        }
    }
    
    @IBAction func plus2Button(_ sender: UIButton) {
        try! realm.write {
            goal.fact += goal.step2
            planLabel.text =  "\(String(goal.fact)) / \(String(goal.plan))  \(goal.units)"
        }
    }
    
    @IBAction func plus3Button(_ sender: UIButton) {
        try! realm.write {
            goal.fact += goal.step3
            planLabel.text =  "\(String(goal.fact)) / \(String(goal.plan))  \(goal.units)"
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        showDeleteAlert()
    }
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
    
    @objc func swipeAction() {
        dismiss(animated: true, completion: nil)
    }

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "deleteSegue" else {return}
        try! realm.write {
            realm.delete(goal)
        }
    }
}

