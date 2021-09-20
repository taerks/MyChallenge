//
//  MainTableViewCell.swift
//  goal2.0
//
//  Created by Антон Ермолов on 05.08.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellDecription(cell: MainGoal){
        self.countLabel.text = String(cell.plan) + " " + cell.units
        self.periodLabel.text = cell.deadline
        self.progressLabel.text = String(cell.fact) + "/" + String(cell.plan)
        
        self.progressView.progress = Float(cell.fact) / Float(cell.plan)
        
        
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIImageView(image: UIImage(named: "MainCellBackground"))
    }
    

}
