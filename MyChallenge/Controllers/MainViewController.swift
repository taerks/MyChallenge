//
//  ViewController.swift
//  goal2.0
//
//  Created by Антон Ермолов on 05.08.2021.
//

import UIKit
import RealmSwift

//MARK: - protocol
protocol MainViewControllerDelegate {
    func toggleMenu()
}

final class MainViewController: UIViewController {
    
    //MARK: - variables
    let realm = try! Realm()
    var delegate: MainViewControllerDelegate?
    var goals: Results<MainGoal>!
    
    //MARK: - outlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var SlaboLabel: UILabel!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        goals = realm.objects(MainGoal.self)
    }
    
    //MARK: - IBActions
    @IBAction func menuButton(_ sender: UIButton) {
        delegate?.toggleMenu()
    }
    
    //MARK: - Router
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        mainTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editGoal" else { return }
        let editScreenVC = segue.destination as! EditScreenViewController
        let indexPath = mainTableView.indexPathForSelectedRow!
        let goal = goals[indexPath.section]
        editScreenVC.goal = goal
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if goals == nil {
            return 0
        }
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        let goal = goals[indexPath.section]
        cell.cellDecription(cell: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}
