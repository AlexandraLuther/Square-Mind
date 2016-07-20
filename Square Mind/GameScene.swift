//
//  GameScene.swift
//  Square Mind
//
//  Created by Alex Luther on 7/12/16.
//  Copyright (c) 2016 Alex Luther. All rights reserved.
//

import SpriteKit

enum GameSceneState {
    case Active, GameOver
}

enum Colors {
    case Yellow, Green, Pink, Blue, Purple
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //speed of scrool
    let scrollSpeed: CGFloat = 250
    
    var scrollLayer: SKNode!
    let fixedDelta: CFTimeInterval = 1.0/60.0
    
    var colorState: Colors = .Green
    
    var buttonRestart: MSButtonNode!
    
    //var play: MSButtonNode
    
    var pink1: MSButtonNode!
    
     var pink2: MSButtonNode!
     var pink3: MSButtonNode!
     var pink4: MSButtonNode!
     var pink5: MSButtonNode!
     var pink6: MSButtonNode!
     var pink7: MSButtonNode!
     var pink8: MSButtonNode!
     var pink9: MSButtonNode!
     var pink10: MSButtonNode!
     var blue1: MSButtonNode!
     var blue2: MSButtonNode!
     var blue3: MSButtonNode!
     var blue4: MSButtonNode!
     var blue5: MSButtonNode!
     var blue6: MSButtonNode!
     var blue7: MSButtonNode!
     var blue8: MSButtonNode!
     var blue9: MSButtonNode!
     var blue10: MSButtonNode!
     var blue11: MSButtonNode!
     var green1: MSButtonNode!
     var green2: MSButtonNode!
     var green3: MSButtonNode!
     var green4: MSButtonNode!
     var green5: MSButtonNode!
     var green6: MSButtonNode!
     var green7: MSButtonNode!
     var green8: MSButtonNode!
     var green9: MSButtonNode!
     var green10: MSButtonNode!
     var yellow1: MSButtonNode!
     var yellow2: MSButtonNode!
     var yellow3: MSButtonNode!
     var yellow4: MSButtonNode!
     var yellow5: MSButtonNode!
     var yellow6: MSButtonNode!
     var yellow7: MSButtonNode!
     var yellow8: MSButtonNode!
     var yellow9: MSButtonNode!
     var yellow10: MSButtonNode!
     var yellow11: MSButtonNode!
     var yellow12: MSButtonNode!
     var yellow13: MSButtonNode!
     var purple1: MSButtonNode!
     var purple2: MSButtonNode!
     var purple3: MSButtonNode!
     var purple4: MSButtonNode!
     var purple5: MSButtonNode!
     var purple6: MSButtonNode!
     var purple7: MSButtonNode!
     var purple8: MSButtonNode!
     var purple9: MSButtonNode!
     var purple10: MSButtonNode!
    
    //how do I not make it a stored compound
    var gameState: GameSceneState = .Active
    
    func didBeginContact(contact: SKPhysicsContact) {
        /* Ensure only called while game running */
        if gameState != .Active { return }
        
        /* Hero touches anything, game over */
        
        /* Change game state to game over */
        gameState = .GameOver
        
        /* Stop any new angular velocity being applied
         hero.physicsBody?.allowsRotation = false
         
         Reset angular velocity
         hero.physicsBody?.angularVelocity = 0
         
         Stop hero flapping animation
         hero.removeAllActions()
         */
        /* Show restart button */
//        buttonRestart.state = .MSButtonNodeStateActive
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Disable touch if game state is not active */
        if gameState != .Active { return }
        
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Set reference to scroll layer node */
        scrollLayer = self.childNodeWithName("scrollLayer")
        //scrollLayer = SKNode()
        
        buttonRestart = self.childNodeWithName("buttonRestart") as! MSButtonNode
        /* Setup restart button selection handler */
        
        
            
        buttonRestart.selectedHandler = {
            
            print("restart tapped!")
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
            
            
            
            self.buttonRestart.state = .MSButtonNodeStateHidden
        }
       // play = self.childNodeWithName("buttonRestart") as! MSButtonNode

// here
        pink1 = scrollLayer.childNodeWithName("pink1") as! MSButtonNode
        pink1.selectedHandler = {
            self.colorState = .Pink
        }
        
         pink2 = scrollLayer.childNodeWithName("pink2") as! MSButtonNode
         pink3 = scrollLayer.childNodeWithName("pink3") as! MSButtonNode
         pink4 = scrollLayer.childNodeWithName("pink4") as! MSButtonNode
         pink5 = scrollLayer.childNodeWithName("pink5") as! MSButtonNode
         pink6 = scrollLayer.childNodeWithName("pink6") as! MSButtonNode
         pink7 = scrollLayer.childNodeWithName("pink7") as! MSButtonNode
         pink8 = scrollLayer.childNodeWithName("pink8") as! MSButtonNode
         pink9 = scrollLayer.childNodeWithName("pink9") as! MSButtonNode
         pink10 = scrollLayer.childNodeWithName("pink10") as! MSButtonNode
         blue1 = scrollLayer.childNodeWithName("blue1") as! MSButtonNode
         blue2 = scrollLayer.childNodeWithName("blue2") as! MSButtonNode
         blue3 = scrollLayer.childNodeWithName("blue3") as! MSButtonNode
         blue4 = scrollLayer.childNodeWithName("blue4") as! MSButtonNode
         blue5 = scrollLayer.childNodeWithName("blue5") as! MSButtonNode
         blue6 = scrollLayer.childNodeWithName("blue6") as! MSButtonNode
         blue7 = scrollLayer.childNodeWithName("blue7") as! MSButtonNode
         blue8 = scrollLayer.childNodeWithName("blue8") as! MSButtonNode
         blue9 = scrollLayer.childNodeWithName("blue9") as! MSButtonNode
         blue10 = scrollLayer.childNodeWithName("blue10") as! MSButtonNode
         blue11 = scrollLayer.childNodeWithName("blue11") as! MSButtonNode
         green1 = scrollLayer.childNodeWithName("green1") as! MSButtonNode
         green2 = scrollLayer.childNodeWithName("green2") as! MSButtonNode
         green3 = scrollLayer.childNodeWithName("green3") as! MSButtonNode
         green4 = scrollLayer.childNodeWithName("green4") as! MSButtonNode
         green5 = scrollLayer.childNodeWithName("green5") as! MSButtonNode
         green6 = scrollLayer.childNodeWithName("green6") as! MSButtonNode
         green7 = scrollLayer.childNodeWithName("green7") as! MSButtonNode
         green8 = scrollLayer.childNodeWithName("green8") as! MSButtonNode
         green9 = scrollLayer.childNodeWithName("green9") as! MSButtonNode
         green10 = scrollLayer.childNodeWithName("green10") as! MSButtonNode
         yellow1 = scrollLayer.childNodeWithName("yellow1") as! MSButtonNode
         yellow2 = scrollLayer.childNodeWithName("yellow2") as! MSButtonNode
         yellow3 = scrollLayer.childNodeWithName("yellow3") as! MSButtonNode
         yellow4 = scrollLayer.childNodeWithName("yellow4") as! MSButtonNode
         yellow5 = scrollLayer.childNodeWithName("yellow5") as! MSButtonNode
         yellow6 = scrollLayer.childNodeWithName("yellow6") as! MSButtonNode
         yellow7 = scrollLayer.childNodeWithName("yellow7") as! MSButtonNode
         yellow8 = scrollLayer.childNodeWithName("yellow8") as! MSButtonNode
         yellow9 = scrollLayer.childNodeWithName("yellow9") as! MSButtonNode
         yellow10 = scrollLayer.childNodeWithName("yellow10") as! MSButtonNode
         yellow11 = scrollLayer.childNodeWithName("yellow11") as! MSButtonNode
         yellow12 = scrollLayer.childNodeWithName("yellow12") as! MSButtonNode
         yellow13 = scrollLayer.childNodeWithName("yellow13") as! MSButtonNode
         purple1 = scrollLayer.childNodeWithName("purple1") as! MSButtonNode
         purple2 = scrollLayer.childNodeWithName("purple2") as! MSButtonNode
         purple3 = scrollLayer.childNodeWithName("purple3") as! MSButtonNode
         purple4 = scrollLayer.childNodeWithName("purple4") as! MSButtonNode
         purple5 = scrollLayer.childNodeWithName("purple5") as! MSButtonNode
         purple6 = scrollLayer.childNodeWithName("purple6") as! MSButtonNode
         purple7 = scrollLayer.childNodeWithName("purple7") as! MSButtonNode
         purple8 = scrollLayer.childNodeWithName("purple8") as! MSButtonNode
         purple9 = scrollLayer.childNodeWithName("purple9") as! MSButtonNode
         purple10 = scrollLayer.childNodeWithName("purple10") as! MSButtonNode
         
         
         
         
         
         pink2.selectedHandler = {
         self.colorState = .Pink
         }
         pink3.selectedHandler = {
         self.colorState = .Pink
         }
         pink4.selectedHandler = {
         self.colorState = .Pink
         }
         pink5.selectedHandler = {
         self.colorState = .Pink
         }
         pink6.selectedHandler = {
         self.colorState = .Pink
         }
         pink7.selectedHandler = {
         self.colorState = .Pink
         }
         pink8.selectedHandler = {
         self.colorState = .Pink
         }
         pink9.selectedHandler = {
         self.colorState = .Pink
         }
         pink10.selectedHandler = {
         self.colorState = .Pink
         }
         blue1.selectedHandler = {
         self.colorState = .Blue
         }
         blue2.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue3.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue4.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue5.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue6.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue7.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue8.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue9.selectedHandler = {
         self.colorState = .Blue
         }
         
         blue10.selectedHandler = {
         self.colorState = .Blue
         }
         blue11.selectedHandler = {
         self.colorState = .Blue
         }
         
         green1.selectedHandler = {
         self.colorState = .Green
         }
         green2.selectedHandler = {
         self.colorState = .Green
         }
         
         green3.selectedHandler = {
         self.colorState = .Green
         }
         
         green4.selectedHandler = {
         self.colorState = .Green
         }
         
         green5.selectedHandler = {
         self.colorState = .Green
         }
         
         green6.selectedHandler = {
         self.colorState = .Green
         }
         
         green7.selectedHandler = {
         self.colorState = .Green
         }
         
         green8.selectedHandler = {
         self.colorState = .Green
         }
         
         green9.selectedHandler = {
         self.colorState = .Green
         }
         
         green10.selectedHandler = {
         self.colorState = .Green
         }
         
         yellow1.selectedHandler = {
         self.colorState = .Yellow
         
         }
         yellow2.selectedHandler = {
         self.colorState = .Yellow
         
         }
         yellow3.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow4.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow5.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow6.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow7.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow8.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow9.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow10.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow11.selectedHandler = {
         self.colorState = .Yellow
         }
         
         yellow12.selectedHandler = {
         self.colorState = .Yellow
         }
         //13 is bellow
         
         purple1.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple2.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple3.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple4.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple5.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple6.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple7.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple8.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple9.selectedHandler = {
         self.colorState = .Purple
         }
         
         purple1.selectedHandler = {
         self.colorState = .Purple
         }
         
         yellow13.selectedHandler = {
         
         /* Grab reference to our SpriteKit view */
         let skView = self.view as SKView!
         
         
         /* Ensure correct aspect mode */
         //scene.scaleMode = .AspectFill
         
         //how do I call the button?
         }
         
        
    }
    
    
    func scrollWorld() {
        /* Scroll World */
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
    }
    
    override func update(currentTime: CFTimeInterval) {
        

        /* Skip game update if game no longer active */
        if gameState != .Active { return }
        /* Called before each frame is rendered */
        //timer.update()
        /* Process world scrolling */
        if self.colorState == .Blue || self.colorState == .Pink {
                        
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
        }

        scrollWorld()
    }
}

