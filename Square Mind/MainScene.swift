//
//  MainScene.Swift
//  Square Mind
//
//  Created by Alex Luther on 7/26/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    let gameManager = GameManager.sharedInstance
    /* UI Connections */
    var buttonPlay1: MSButtonNode!
    var quetionmark: MSButtonNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var text5: SKLabelNode!
    var text6: SKLabelNode!
    var text7: SKLabelNode!
    var text8: SKLabelNode!
    var text9: SKLabelNode!
    var arrow1: SKNode!
    var arrow2: SKNode!
    var arrow3: SKNode!
    var arrow4: SKNode!
    var type1:SKLabelNode!
    var type2:SKLabelNode!
    var type3:SKLabelNode!
    var type4:SKLabelNode!
    var backgroundForText: SKSpriteNode!
    var xoutbutton: MSButtonNode!
    var musicOn: MSButtonNode!
    var musicOff: MSButtonNode!
    var TriangleAndSquare: MSButtonNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        TriangleAndSquare = self.childNodeWithName("TriangleAndSquare") as! MSButtonNode
         xoutbutton = self.childNodeWithName("xoutbutton") as! MSButtonNode
        quetionmark = self.childNodeWithName("quetionmark") as! MSButtonNode
        /* Set UI connections */
        buttonPlay1 = self.childNodeWithName("buttonPlay") as! MSButtonNode
        backgroundForText = self.childNodeWithName("backgroundForText") as! SKSpriteNode!
        text1 = self.childNodeWithName("text1") as! SKLabelNode
        text2 = self.childNodeWithName("text2") as! SKLabelNode
        text3 = self.childNodeWithName("text3") as! SKLabelNode
        text4 = self.childNodeWithName("text4") as! SKLabelNode
        text5 = self.childNodeWithName("text5") as! SKLabelNode
        text6 = self.childNodeWithName("text6") as! SKLabelNode
        text7 = self.childNodeWithName("text7") as! SKLabelNode
        text8 = self.childNodeWithName("text8") as! SKLabelNode
        text9 = self.childNodeWithName("text9") as! SKLabelNode
        musicOn = self.childNodeWithName("musicOn") as! MSButtonNode
        musicOff = self.childNodeWithName("musicOff") as! MSButtonNode
        
        if gameManager.mute == true {
            musicOn.hidden = true
            musicOff.hidden = false
        } else if gameManager.mute == false {
            musicOn.hidden = false
            musicOff.hidden = true
        }
        
        xoutbutton.hidden = true
        backgroundForText.hidden = true
        text1.hidden = true
        text2.hidden = true
        text3.hidden = true
        text4.hidden = true
        text5.hidden = true
        text6.hidden = true
        text7.hidden = true
        text8.hidden = true
        text9.hidden = true
      
        musicOn.selectedHandler = {
            self.gameManager.mute = true
            self.musicOff.hidden = false
            self.musicOn.hidden = true
        }
        musicOff.selectedHandler = {
            self.gameManager.mute = false
            self.musicOff.hidden = true
            self.musicOn.hidden = false
        }
        quetionmark.selectedHandler = {
            self.backgroundForText.hidden = false
            self.text1.hidden = false
            self.text2.hidden = false
            self.text3.hidden = false
            self.text4.hidden = false
            self.text5.hidden = false
            self.text6.hidden = false
            self.text7.hidden = false
            self.text8.hidden = false
            self.text9.hidden = false
          
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
            self.text5.hidden = true
            self.text6.hidden = true
            self.text7.hidden = true
            self.text8.hidden = true
            self.text9.hidden = true
            self.quetionmark.hidden = false
            
        }
        TriangleAndSquare.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)

        }
        /* Setup restart button selection handler */
        buttonPlay1.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene1(fileNamed:"GameScene1") as GameScene1!
            
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
