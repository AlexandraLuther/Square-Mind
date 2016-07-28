//
//  MainScene.Swift
//  Square Mind
//
//  Created by Alex Luther on 7/26/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var quetionmark: MSButtonNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var backgroundForText: SKSpriteNode!
    var xoutbutton: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
         xoutbutton = self.childNodeWithName("xoutbutton") as! MSButtonNode
        quetionmark = self.childNodeWithName("quetionmark") as! MSButtonNode
        /* Set UI connections */
        buttonPlay = self.childNodeWithName("buttonPlay") as! MSButtonNode
        backgroundForText = self.childNodeWithName("backgroundForText") as! SKSpriteNode!
        text1 = self.childNodeWithName("text1") as! SKLabelNode
        text2 = self.childNodeWithName("text2") as! SKLabelNode
        text3 = self.childNodeWithName("text3") as! SKLabelNode
        text4 = self.childNodeWithName("text4") as! SKLabelNode
        xoutbutton.hidden = true
        backgroundForText.hidden = true
        text1.hidden = true
        text2.hidden = true
        text3.hidden = true
        text4.hidden = true
        
        quetionmark.selectedHandler = {
            self.backgroundForText.hidden = false
            self.text1.hidden = false
            self.text2.hidden = false
            self.text3.hidden = false
            self.text4.hidden = false
            self.xoutbutton.hidden = false
            self.quetionmark.hidden = true
        }
        xoutbutton.selectedHandler = {
            self.xoutbutton.hidden = true
            self.backgroundForText.hidden = true
            self.text1.hidden = true
            self.text2.hidden = true
            self.text3.hidden = true
            self.text4.hidden = true
            self.quetionmark.hidden = false
            
        }
        
        /* Setup restart button selection handler */
        buttonPlay.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
    }
    
}
