//
//  Model.swift
//  goal2.0
//
//  Created by Антон Ермолов on 05.08.2021.
//

import Foundation
import RealmSwift

class MainGoal: Object {
    
    @Persisted var fact: Int = 0
    @Persisted var plan: Int
    @Persisted var units: String
    @Persisted var deadline: String
    @Persisted var step1: Int
    @Persisted var step2: Int
    @Persisted var step3: Int
    
    convenience init(fact: Int,
                     plan: Int,
                     units: String,
                     deadline: String,
                     step1: Int,
                     step2: Int,
                     step3: Int) {
        self.init()
        self.fact = fact
        self.plan = plan
        self.units = units
        self.deadline = deadline
        self.step1 = step1
        self.step2 = step2
        self.step3 = step3
    }
}

