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
    static let highScoreLevel1 = DefaultsKey<Int>("highScoreLevel1")
    static let highScoreLevel3 = DefaultsKey<Int>("highScoreLevel3")
    static let highScoreShape = DefaultsKey<Int>("highScoreShape")
    static let mute = DefaultsKey<Bool>("mute")

}

class GameManager : CustomStringConvertible {
    
    /* Swift Singleton */
    static let sharedInstance = GameManager()
    
    /* Properties */
    var highScore = 0
    var highScoreShape = 0
    var mute = false
    var highScoreLevel1 = 0
    var highScoreLevel3 = 0
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
        Defaults[.highScoreLevel1] = highScoreLevel1
        Defaults[.mute] = mute
        Defaults[.highScoreLevel3] = highScoreLevel3
        
        /* Debug */
        print(self)
    }
    
    func loadData() {
        /* Populate specified properties with stored data */
        print("GameManager: loadData")
        
        highScore = Defaults[.highScore]
        highScoreShape = Defaults[.highScoreShape]
        mute = Defaults[.mute]
        highScoreLevel1 = Defaults[.highScoreLevel1]
        highScoreLevel3 = Defaults[.highScoreLevel3]
    }
    
    
}
