//
//  MenuTableViewCell.swift
//  MyChallenge
//
//  Created by Антон Ермолов on 20.09.2021.
//


import UIKit

class MenuTableViewCell: UITableViewCell {

    static let reuseId = "MenuTableCell"
    
    let iconImageView: UIImageView = {
       let iconImage = UIImageView()
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .scaleAspectFit
        iconImage.clipsToBounds = true

        return iconImage
    }()
    
    let menuLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        addSubview(menuLabel)
        
        backgroundColor = .clear
        
        //MARK: iconImageView constraints
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        //MARK: menuLabel constraints
        menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        menuLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
