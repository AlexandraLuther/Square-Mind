//
//  File.swift
//  Square Mind
//
//  Created by Alex Luther on 7/13/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import SpriteKit

class CountDownLabel: SKLabelNode {
    
    var endTime:NSDate!
    func update(){
        let timeLeftInteger = Int(timeLeft())
        text = String(timeLeftInteger)
        
    }
    
    
    func startWithDuration(duration: NSTimeInterval){
        
        let timeNow = NSDate();
        endTime = timeNow.dateByAddingTimeInterval(duration)
        
    }
        private func timeLeft() -> NSTimeInterval{
            
            let now = NSDate();
            let remainingSEcond = endTime.timeIntervalSinceNow
            return max(remainingSEcond, 0)
            
        }
    
    
    func hasFinished() -> Bool{
        return timeLeft() == 0;
        
        
    }
    
}