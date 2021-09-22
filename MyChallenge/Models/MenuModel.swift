//
//  MenuModel.swift
//  MyChallenge
//
//  Created by Антон Ермолов on 20.09.2021.
//

import UIKit

enum MenuModel: Int {
    
    case Archiv
    case Contacts
    case Settings
    
    var description: String {
        switch self {
        case .Archiv: return "Archive"
        case .Contacts: return "Contacts"
        case .Settings: return "Settings"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Archiv: return UIImage(named: "Archive") ?? UIImage()
        case .Contacts: return UIImage(named: "Contacts") ?? UIImage()
        case .Settings: return UIImage(named: "Settings") ?? UIImage()
        }
    }
}

