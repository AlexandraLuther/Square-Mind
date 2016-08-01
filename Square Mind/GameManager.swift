//
//  GameManager.swift
//  Square Mind
//
//  Created by Alex Luther on 7/28/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import Foundation

/* Define properties to be stored in NSUserDefaults */
extension DefaultsKeys {
    static let highScore = DefaultsKey<Int>("highScore")
    static let highScoreShape = DefaultsKey<Int>("highScoreShape")
}

class GameManager : CustomStringConvertible {
    
    /* Swift Singleton */
    static let sharedInstance = GameManager()
    
    /* Properties */
    var highScore = 0
    var highScoreShape = 0
    
    /* Debug description */
    var description:String {
        return "High Score: \(highScore)"
    }
    
    
    private init() {
        /* Load stored data by default */
        print("GameManager: Initialised")
        loadData()
        
        
    }
    
    func saveData() {
        /* Store specified property data */
        print("GameManager: saveData")
        
        Defaults[.highScore] = highScore
        Defaults[.highScoreShape] = highScoreShape
        
        
        
        /* Debug */
        print(self)
    }
    
    func loadData() {
        /* Populate specified properties with stored data */
        print("GameManager: loadData")
        
        highScore = Defaults[.highScore]
        highScoreShape = Defaults[.highScoreShape]
        
        
        
    }
    
    
}