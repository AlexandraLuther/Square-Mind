//
//  MSReferenceNodeShape.swift
//  Square Mind
//
//  Created by Alex Luther on 7/29/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import Foundation
import SpriteKit

class MSReferenceNodeShape: SKReferenceNode {
    
    /* Avatar node connection */
    var triangleType1: SKSpriteNode!
    var triangleType2: SKSpriteNode!
    var SquareType1: SKSpriteNode!
    var SquareType2: SKSpriteNode!
    
    
    
    override func didLoadReferenceNode(node: SKNode?) {
        
        triangleType2 = childNodeWithName("//triangleType2") as! SKSpriteNode
        triangleType1 = childNodeWithName("//triangleType1") as! SKSpriteNode
        SquareType1 = childNodeWithName("//SquareType1") as! SKSpriteNode
        SquareType2 = childNodeWithName("//SquareType2") as! SKSpriteNode
        
    }
    
}