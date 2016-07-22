//
//  MSPhysicsNode.swift
//  Make School
//
//  Created by Martin Walsh on 15/03/2016.
//  Copyright © 2016 Martin Walsh. All rights reserved.
//

import SpriteKit

class MSReferenceNode: SKReferenceNode {
    
    /* Avatar node connection */
    var NodeTypeColor1: SKSpriteNode!
    var NodeTypeColor2: SKSpriteNode!
    var NodeTypeColor3: SKSpriteNode!
    var NodeTypeColor4: SKSpriteNode!
    var NodeTypeColor5: SKSpriteNode!
    
    
    override func didLoadReferenceNode(node: SKNode?) {
        
        /* Set reference to avatar node */
        NodeTypeColor1 = childNodeWithName("//NodeTypeColor1") as! SKSpriteNode
        NodeTypeColor2 = childNodeWithName("//NodeTypeColor2") as! SKSpriteNode
        NodeTypeColor3 = childNodeWithName("//NodeTypeColor3") as! SKSpriteNode
        NodeTypeColor4 = childNodeWithName("//NodeTypeColor4") as! SKSpriteNode
        NodeTypeColor5 = childNodeWithName("//NodeTypeColor5") as! SKSpriteNode
    }

}