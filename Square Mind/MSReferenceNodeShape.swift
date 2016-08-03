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
    var NodeTypeShapeColor1: SKSpriteNode!
    
    
    override func didLoadReferenceNode(node: SKNode?) {
        triangleType1 = childNodeWithName("//triangleType1") as! SKSpriteNode
        NodeTypeShapeColor1 = childNodeWithName("//NodeTypeShapeColor1") as! SKSpriteNode
    }
}