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

//enum Colors {
//    case Colortype1, Colortype2, Colortype3, Colortype4, Colortype5
//}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //speed of scrool
    let scrollSpeed: CGFloat = 170
    var obstacleLayer: SKNode!
    let fixedDelta: CFTimeInterval = 1.0/60.0
  //  var colorState: SKColor = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
    //var buttonRestart: MSButtonNode!
    var spawnTimer: CFTimeInterval = 0
    var spawnTimerFixed: CFTimeInterval = 7.0
    var colortype1: SKNode!
    var correctColor1: SKSpriteNode!
    var correctColor2: SKSpriteNode!
    var correctColor3: SKSpriteNode!
    var incorrectColor1: SKSpriteNode!
    var incorrectColor2: SKSpriteNode!
    var lives: Int = 3
    var scoreLabel: SKLabelNode!
    var score: Int =  0
    
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
        
        for touch in touches {
            
            /* Grab position of touch relative to the grid */
            let location  = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            //var node2 = SKSpriteNode(imageNamed: node.name!)
            print(node.name)
            
            if node.name == "wrong"  {
                // and maby tap occured
                lives -= 1
                print("You now have \(lives) lives.")
                
            } else if node.name == "correctblock" {
                score += 1
                scoreLabel.text = String("\(score)")

                node.zPosition = -30
                print("Now the score is:\(score)")
            }
            
        }
        
        
        
        /* Reset touch timer */
        
        
        
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Set reference to scroll layer node */
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        //scrollLayer = SKNode()
        
        /*buttonRestart = self.childNodeWithName("buttonRestart") as! MSButtonNode
 */
        /* Setup restart button selection handler */
        
        
        pickAColor()
        
        correctColor1 = childNodeWithName("correctColor1") as! SKSpriteNode
        correctColor2 = childNodeWithName("correctColor2") as! SKSpriteNode
        correctColor3 = childNodeWithName("correctColor3") as! SKSpriteNode
        incorrectColor1 = childNodeWithName("incorrectColor1") as! SKSpriteNode
        incorrectColor2 = childNodeWithName("incorrectColor2") as! SKSpriteNode
        
        correctColor1.color = colors[0]!
        correctColor2.color = colors[1]!
        correctColor3.color = colors[2]!
        incorrectColor1.color = colors[3]!
        incorrectColor2.color = colors[4]!
        
        createNewObstical(1200)
        
        //colorState = colors[0]!
        
        /*
        
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
        */
        // play = self.childNodeWithName("buttonRestart") as! MSButtonNode
        
        // here
        /* Grab reference to our SpriteKit view */
        let skView = self.view as SKView!
        
        
        /* Ensure correct aspect mode */
        //scene.scaleMode = .AspectFillscoreLabel
        // somthing here is wrong
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        scoreLabel.text = String("\(score)")
        
        
    }
    
    func createNewObstical(distanceFromLast: CGFloat) {
        var newObstacle:MSReferenceNode!
        
        let randomScene = Int(arc4random_uniform(4))
        print(randomScene)
        if randomScene == 0 {
            let resourcePath = NSBundle.mainBundle().pathForResource("SceneType1", ofType: "sks")
            newObstacle = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 1 {
            let resourcePath = NSBundle.mainBundle().pathForResource("SceneType2", ofType: "sks")
            newObstacle = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 2 {
            let resourcePath = NSBundle.mainBundle().pathForResource("SceneType3", ofType: "sks")
            newObstacle = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 3 {
            let resourcePath = NSBundle.mainBundle().pathForResource("SceneType4", ofType: "sks")
            newObstacle = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else  {
            let resourcePath = NSBundle.mainBundle().pathForResource("SceneType5", ofType: "sks")
            newObstacle = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        }
        
        
        let colorOrder = Int(arc4random_uniform(4))
        if colorOrder == 0 {
            newObstacle.NodeTypeColor1.color = colors[0]!
            newObstacle.NodeTypeColor1.name = "correctblock"
            newObstacle.NodeTypeColor2.color = colors[1]!
            newObstacle.NodeTypeColor2.name = "correctblock"
            newObstacle.NodeTypeColor3.color = colors[2]!
            newObstacle.NodeTypeColor3.name = "correctblock"
            newObstacle.NodeTypeColor4.color = colors[3]!
            newObstacle.NodeTypeColor4.name = "wrong"
            newObstacle.NodeTypeColor5.color = colors[4]!
            newObstacle.NodeTypeColor5.name = "wrong"
        } else if colorOrder == 1 {
            newObstacle.NodeTypeColor1.color = colors[1]!
            newObstacle.NodeTypeColor1.name = "correctblock"
            newObstacle.NodeTypeColor2.color = colors[2]!
            newObstacle.NodeTypeColor2.name = "correctblock"
            newObstacle.NodeTypeColor3.color = colors[4]!
            newObstacle.NodeTypeColor3.name = "wrong"
            newObstacle.NodeTypeColor4.color = colors[0]!
            newObstacle.NodeTypeColor4.name = "correctblock"
            newObstacle.NodeTypeColor5.color = colors[3]!
            newObstacle.NodeTypeColor5.name = "wrong"
        } else if colorOrder == 2 {
            newObstacle.NodeTypeColor1.color = colors[2]!
            newObstacle.NodeTypeColor1.name = "correctblock"
            newObstacle.NodeTypeColor2.color = colors[3]!
            newObstacle.NodeTypeColor2.name = "wrong"
            newObstacle.NodeTypeColor3.color = colors[0]!
            newObstacle.NodeTypeColor3.name = "correctblock"
            newObstacle.NodeTypeColor4.color = colors[4]!
            newObstacle.NodeTypeColor4.name = "wrong"
            newObstacle.NodeTypeColor5.color = colors[1]!
            newObstacle.NodeTypeColor5.name = "correctblock"

        } else if colorOrder == 3 {
            newObstacle.NodeTypeColor1.color = colors[4]!
            newObstacle.NodeTypeColor1.name = "wrong"
            newObstacle.NodeTypeColor2.color = colors[0]!
            newObstacle.NodeTypeColor2.name = "correctblock"
            newObstacle.NodeTypeColor3.color = colors[3]!
            newObstacle.NodeTypeColor3.name = "wrong"
            newObstacle.NodeTypeColor4.color = colors[1]!
            newObstacle.NodeTypeColor4.name = "correctblock"
            newObstacle.NodeTypeColor5.color = colors[2]!
            newObstacle.NodeTypeColor5.name = "correctblock"

        }
        
        /* Create a new obstacle reference object using our obstacle resource */
       // let resourcePath = NSBundle.mainBundle().pathForResource("Obstacle", ofType: "sks")
        
        
        /* Generate new obstacle position, start just outside screen and with a random y value */
        let Position = CGPointMake(distanceFromLast, 0)
        
        /* Convert new node position back to obstacle layer space */
        newObstacle.position = self.convertPoint(Position, toNode: obstacleLayer)
        
    }
    
    
    func updateObstacles() {
        /* Update Obstacles */
        
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            
            /* Check if obstacle has left the scene */
            if spawnTimer >= spawnTimerFixed /*change to timer*/{
                
                createNewObstical(360)
                spawnTimer = 0
                spawnTimerFixed = 2.4
            }
            /* Remove obstacle node from obstacle layer */
            
            if obstaclePosition.x <= -360 {
                obstacle.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
        
        /* Skip game update if game no longer active */
        if gameState != .Active { return }
        /* Called before each frame is rendered */
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        updateObstacles()
        //timer.update()
        /* Process world scrolling */
        
      
        spawnTimer += fixedDelta
    }
    
    var colors = [SKColor?](count: 6, repeatedValue: nil)
    func pickAColor() {
        
        let colorOrder = Int(arc4random_uniform(4))
        if colorOrder == 0 {
            colors[0] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[1] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[2] = SKColor(red: 252/255, green:186/255, blue: 211/255, alpha: 1.0)
            colors[3] = SKColor(red: 255/255, green: 225/255, blue: 196/255, alpha: 1.0)
            colors[4] = SKColor(red: 255/255, green: 255/255, blue: 210/255, alpha: 1.0)
        } else if colorOrder == 1 {
            colors[0] = SKColor(red: 252/255, green: 186/255, blue: 211/255, alpha: 1.0)
            colors[1] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[2] = SKColor(red: 255/255, green: 255/255, blue: 210/255, alpha: 1.0)
            colors[3] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[4] = SKColor(red: 255/255, green: 225/255, blue: 196/255, alpha: 1.0)
        } else if colorOrder == 2 {
            colors[0] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[1] = SKColor(red: 255/255, green: 255/255, blue: 210/255, alpha: 1.0)
            colors[2] = SKColor(red: 255/255, green: 225/255, blue: 196/255, alpha: 1.0)
            colors[3] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[4] = SKColor(red: 252/255, green:186/255, blue: 211/255, alpha: 1.0)
        } else  {
            colors[0] = SKColor(red: 255/255, green: 255/255, blue: 210/255, alpha: 1.0)
            colors[1] = SKColor(red: 255/255, green: 225/255, blue: 196/255, alpha: 1.0)
            colors[2] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[3] = SKColor(red: 252/255, green: 186/255, blue: 211/255, alpha: 1.0)
            colors[4] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
        }
        
    }

}

