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
    
    
    
    
    override func didLoadReferenceNode(node: SKNode?) {
        
        /* Set reference to avatar node */
        NodeTypeColor1 = childNodeWithName("//NodeTypeColor1") as! SKSpriteNode
        
        
    }

}