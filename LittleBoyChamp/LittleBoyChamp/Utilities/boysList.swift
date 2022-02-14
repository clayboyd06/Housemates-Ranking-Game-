//
//  boysList.swift
//  LittleBoyChamp
//
//  Created by Clay Boyd on 2/11/22.
//

import Foundation

class Lad {
    var firstName:String
    var lastName:String
    var photoPath:String
    var score: Int
    
    init(firstName:String, lastName:String, photoPath:String, score:Int) {
        self.firstName=firstName
        self.lastName=lastName
        self.photoPath=photoPath
        self.score=score
    }    
}
