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

class GameScene: SKScene, SKPhysicsContactDelegate {
    var homebutton: MSButtonNode!
    var highscorelable: SKLabelNode!
    // change highscore
    var highscore: SKLabelNode!
    var Finalscore: SKLabelNode!
    var endOfGameButtonRestart: MSButtonNode!
    //speed of scrool
    var scrollSpeed: CGFloat = 170
    var obstacleLayer: SKNode!
    let fixedDelta: CFTimeInterval = 1.0/60.0
    // attempt to implement restar button ///
    var duringGameButtonRestart: MSButtonNode!
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
    var lastLife: SKNode!
    var secondLife: SKNode!
    var firstLife: SKNode!
    
    
    //how do I not make it a stored compound
    var gameState: GameSceneState = .Active
    
    func didBeginContact(/*contact: SKPhysicsContact*/) {
        /* Ensure only called while game running */
        //if gameState != .Active { return }
        homebutton.hidden = false
        highscore.hidden = false
        highscorelable.hidden = false
        Finalscore.hidden = false
        /* Show restart button */
        duringGameButtonRestart.hidden = true
        scoreLabel.position.x = 154
        scoreLabel.position.y = 250
        endOfGameButtonRestart.hidden = false
        scrollSpeed = 0
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Disable touch if game state is not active */
        if gameState != .Active { return }
        
        for touch in touches {
            
            /* Grab position of touch relative to the grid */
            let location  = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            //var node2 = SKSpriteNode(imageNamed: node.name!)
            print(node.name)
            
            if node.name == "wrong"  {
                // and maby tap occured
                lives -= 1
                let faileffect = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
                self.runAction(faileffect)
                
                let wrongpt1 = SKEmitterNode(fileNamed: "wrongpt1")!
                let wrongpt2 = SKEmitterNode(fileNamed: "wrongpt2")!
                let wrongpt3 = SKEmitterNode(fileNamed: "wrongpt3")!
                let wrongpt4 = SKEmitterNode(fileNamed: "wrongpt4")!
                
                /* location of border of wrong move */
                wrongpt1.position.x = 20
                wrongpt1.position.y = 10
                wrongpt2.position.x = 20
                wrongpt2.position.y = 10
                wrongpt3.position.x = 290
                wrongpt3.position.y = 100
                wrongpt4.position.x = 150
                wrongpt4.position.y = 470
                
                //partical.runAction(SKAction.removeFromParentAfterDelay(10))
                /* Restrict total particles to reduce runtime of particle */
                wrongpt1.numParticlesToEmit = 75
                wrongpt2.numParticlesToEmit = 75
                wrongpt4.numParticlesToEmit = 75
                wrongpt3.numParticlesToEmit = 75
                /* Add particles to scene */
                addChild(wrongpt1)
                addChild(wrongpt2)
                addChild(wrongpt4)
                addChild(wrongpt3)
                
                print("You now have \(lives) lives.")
                
            } else if node.name == "correctblock" {
                score += 1
                /* Load our particle effect */
                let partical = SKEmitterNode(fileNamed: "CorrectColor")!
                
                /* Convert node location (currently inside Level 1, to scene space) */
                partical.position = convertPoint(location, fromNode: self)
                print(partical.position)
                print(location)
                //partical.runAction(SKAction.removeFromParentAfterDelay(10))
                /* Restrict total particles to reduce runtime of particle */
                partical.numParticlesToEmit = 75
                
                /* Add particles to scene */
                addChild(partical)
                
                let correctsound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
                self.runAction(correctsound)
                
                scoreLabel.text = String("\(score)")
                node.name = "tappedblock"
                node.zPosition = -30
                print("Now the score is:\(score)")
                
               
            }
            
        }
        
    }
    func lossOfLives(){
        firstLife = self.childNodeWithName("firstLife")
        secondLife = self.childNodeWithName("secondLife")
        lastLife = self.childNodeWithName("lastLife")
        if lives == 3 {
        } else if lives == 2 {
            firstLife.hidden = true
        } else if lives == 1 {
            secondLife.hidden = true
            firstLife.hidden = true
        } else {
            lastLife.hidden = true
            gameState = .GameOver
            didBeginContact()
            // make the game restart
            /* Grab reference to our SpriteKit view
            let skView = self.view as SKView!
            
            /* Load Game scene */
            if let scene = GameScene(fileNamed:"GameScene") {
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
        }*/
    }
    }
    func increaseSpeed() {
        if score <= 10 {
            scrollSpeed = 170
        } else if score <= 25{
            scrollSpeed = 210
        }else if score <= 50{
            scrollSpeed = 240
        }else if score <= 75 {
            scrollSpeed = 270
        } else if score <= 100 {
            scrollSpeed = 300
        } else if score <= 150 {
            scrollSpeed = 330
        } else {
            scrollSpeed = 360
        }
    }
    
    // changebutton
    func homeButtonSelected() {
        homebutton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            
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
    
    override func didMoveToView(view: SKView) {
        homebutton = self.childNodeWithName("homebutton") as! MSButtonNode
        highscorelable = self.childNodeWithName("highscorelable") as! SKLabelNode
        highscore = self.childNodeWithName("highscore") as! SKLabelNode
        Finalscore = self.childNodeWithName("Finalscore")as! SKLabelNode
        homebutton.hidden = true
        highscore.hidden = true
        highscorelable.hidden = true
        Finalscore.hidden = true
        
        
        /* Set reference to scroll layer node */
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        //scrollLayer = SKNode()
        endOfGameButtonRestart = self.childNodeWithName("endOfGameButtonRestart") as! MSButtonNode
        duringGameButtonRestart = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        
        
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
        
        /* Setup restart button selection handler */
        endOfGameButtonRestart.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
        }
        /* Hide restart button */
        endOfGameButtonRestart.hidden = true
        
        duringGameButtonRestart.selectedHandler = {
            
            print("restart tapped!")
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
            
            
            
            self.duringGameButtonRestart.state = .MSButtonNodeStateHidden
        }
        
        let  play = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        
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
        //let resourcePath = NSBundle.mainBundle().pathForResource("Obstacle", ofType: "sks")
        
        
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
                if score <= 10 {
                    spawnTimerFixed = 2.4
                } else if score <= 25 {
                    spawnTimerFixed = 1.92
                } else if score <= 50 {
                    spawnTimerFixed = 1.55
                } else if score <= 75 {
                    spawnTimerFixed = 1.35
                } else if score <= 100 {
                    spawnTimerFixed = 1.22
                } else if score <= 150 {
                    spawnTimerFixed = 1.17
                } else {
                    spawnTimerFixed = 1.15
                }
                
            }
            /* Remove obstacle node from obstacle layer */
            
            if obstaclePosition.x <= -360 {
                obstacle.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        
        
    }
    func mustTap() {
        for obstacle in obstacleLayer.children as! [MSReferenceNode] {
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            if obstaclePosition.x < -350 {
                // print(obstaclePosition)
                if obstacle.NodeTypeColor1.name == "correctblock" || obstacle.NodeTypeColor2.name == "correctblock" || obstacle.NodeTypeColor3.name == "correctblock" || obstacle.NodeTypeColor4.name == "correctblock" || obstacle.NodeTypeColor5.name == "correctblock" {
                    
                    let wrongpt1 = SKEmitterNode(fileNamed: "wrongpt1")!
                    let wrongpt2 = SKEmitterNode(fileNamed: "wrongpt2")!
                    let wrongpt3 = SKEmitterNode(fileNamed: "wrongpt3")!
                    let wrongpt4 = SKEmitterNode(fileNamed: "wrongpt4")!
                    
                    /* location of border of wrong move */
                    wrongpt1.position.x = 20
                    wrongpt1.position.y = 10
                    wrongpt2.position.x = 20
                    wrongpt2.position.y = 10
                    wrongpt3.position.x = 290
                    wrongpt3.position.y = 100
                    wrongpt4.position.x = 150
                    wrongpt4.position.y = 470
                    
                    //partical.runAction(SKAction.removeFromParentAfterDelay(10))
                    /* Restrict total particles to reduce runtime of particle */
                    wrongpt1.numParticlesToEmit = 75
                    wrongpt2.numParticlesToEmit = 75
                    wrongpt4.numParticlesToEmit = 75
                    wrongpt3.numParticlesToEmit = 75
                    /* Add particles to scene */
                    addChild(wrongpt1)
                    addChild(wrongpt2)
                    addChild(wrongpt4)
                    addChild(wrongpt3)

                    lives -= 1
                    let faileffect = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
                    self.runAction(faileffect)
                    print("you lost a life now\(lives)")
                    obstacle.removeFromParent()
                }
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        homeButtonSelected()
        /* Skip game update if game no longer active */
        if gameState != .Active { return }
        /* Called before each frame is rendered */
        increaseSpeed()
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        mustTap()
        //timer.update()
        /* Process world scrolling */
        
        updateObstacles()
        lossOfLives()
        
        spawnTimer += fixedDelta
    }
    
    var colors = [SKColor?](count: 6, repeatedValue: nil)
    func pickAColor() {
        
        let colorOrder = Int(arc4random_uniform(4))
        if colorOrder == 0 {
            colors[0] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[1] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[2] = SKColor(red: 252/255, green:186/255, blue: 211/255, alpha: 1.0)
            colors[3] = SKColor(red: 154/255, green: 255/255, blue: 154/255, alpha: 1.0)
            colors[4] = SKColor(red: 253/255, green: 253/255, blue: 150/255, alpha: 1.0)
        } else if colorOrder == 1 {
            colors[0] = SKColor(red: 252/255, green: 186/255, blue: 211/255, alpha: 1.0)
            colors[1] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[2] = SKColor(red: 253/255, green: 253/255, blue: 150/255, alpha: 1.0)
            colors[3] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[4] = SKColor(red: 154/255, green: 255/255, blue: 154/255, alpha: 1.0)
        } else if colorOrder == 2 {
            colors[0] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[1] = SKColor(red: 253/255, green: 253/255, blue: 150/255, alpha: 1.0)
            colors[2] = SKColor(red: 154/255, green: 255/255, blue: 154/255, alpha: 1.0)
            colors[3] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
            colors[4] = SKColor(red: 252/255, green:186/255, blue: 211/255, alpha: 1.0)
        } else  {
            colors[0] = SKColor(red: 253/255, green: 253/255, blue: 150/255, alpha: 1.0)
            colors[1] = SKColor(red: 154/255, green: 255/255, blue: 154/255, alpha: 1.0)
            colors[2] = SKColor(red: 170/255, green: 150/255, blue: 218/255, alpha: 1.0)
            colors[3] = SKColor(red: 252/255, green: 186/255, blue: 211/255, alpha: 1.0)
            colors[4] = SKColor(red: 168/255, green: 216/255, blue: 234/255, alpha: 1.0)
        }
        
    }
    
}

