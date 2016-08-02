//
//  GameSceneShape.swift
//  Square Mind
//
//  Created by Alex Luther on 7/29/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import SpriteKit

enum GameSceneShapeState {
    case Active, GameOver, Pause
}

class GameSceneShape: SKScene, SKPhysicsContactDelegate {
    let gameManager = GameManager.sharedInstance
    var homebutton: MSButtonNode!
    var highscorelable: SKLabelNode!
    // change highscore
    var highscoreput: SKLabelNode!
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
    //chage
    var colortype1: SKNode!
    var correctSquare: SKSpriteNode!
    var correctTriangle: SKSpriteNode!
    var incorrectSquare: SKSpriteNode!
    var incorrectTriangle: SKSpriteNode!
    var lives: Int = 3
    var scoreLabel: SKLabelNode!
    var score: Int =  0
    var lastLife: SKNode!
    var secondLife: SKNode!
    var firstLife: SKNode!
    var pauseButton: MSButtonNode!
    var playButton: MSButtonNode!
    
    
    //how do I not make it a stored compound
    var gameState: GameSceneShapeState = .Active
    
    func didBeginContact(/*contact: SKPhysicsContact*/) {
        /* Ensure only called while game running */
        //if gameState != .Active { return }
        
        if gameManager.highScoreShape < score {
            gameManager.highScoreShape = score
        }
        pauseButton.hidden = true
        homebutton.hidden = false
        highscoreput.hidden = false
        highscoreput.text = "\(gameManager.highScoreShape)"
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
        
        }
    }
    func increaseSpeed() {
        if score <= 2 {
            scrollSpeed = 170
        } else if score <= 10{
            scrollSpeed = 210
        }else if score <= 25 {
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
        highscoreput = self.childNodeWithName("//highscoreput") as! SKLabelNode
        Finalscore = self.childNodeWithName("Finalscore")as! SKLabelNode
        playButton = self.childNodeWithName("//playButton") as! MSButtonNode
        pauseButton = self.childNodeWithName("//pauseButton") as! MSButtonNode
        homebutton.hidden = true
        highscoreput.hidden = true
        highscorelable.hidden = true
        Finalscore.hidden = true
        
        playButton.hidden = true
        
        /* Set reference to scroll layer node */
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        //scrollLayer = SKNode()
        endOfGameButtonRestart = self.childNodeWithName("endOfGameButtonRestart") as! MSButtonNode
        duringGameButtonRestart = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        duringGameButtonRestart.hidden = true
        
        /* Setup restart button selection handler */
        
        
        pickAColor()
        
        correctSquare = childNodeWithName("correctSquare") as! SKSpriteNode
        correctTriangle = childNodeWithName("correctTriangle") as! SKSpriteNode
        incorrectTriangle = childNodeWithName("incorrectTriangle") as! SKSpriteNode
        incorrectSquare = childNodeWithName("incorrectSquare") as! SKSpriteNode
        
        correctSquare.color = colors[0]!
        correctTriangle.color = colors[1]!
        incorrectTriangle.color = colors[0]!
        incorrectSquare.color = colors[1]!
        
        
        createNewObstical(1200)
        
        //colorState = colors[0]!
        
        /* Setup restart button selection handler */
        endOfGameButtonRestart.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
        }
        /* Hide restart button */
        endOfGameButtonRestart.hidden = true
        
        pauseButton.selectedHandler = {
            self.gameState = .Pause
            self.scrollSpeed = 0
            self.pauseButton.hidden = true
            self.duringGameButtonRestart.hidden = false
            self.homebutton.hidden = false
            self.playButton.hidden = false
            self.playButton.selectedHandler = {
                self.pauseButton.hidden = false
                self.duringGameButtonRestart.hidden = true
                self.homebutton.hidden = true
                self.playButton.hidden = true
                self.gameState = .Active
                self.increaseSpeed()
            }
            self.duringGameButtonRestart.selectedHandler = {
            print("restart tapped!")
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
            
            
            
            self.duringGameButtonRestart.state = .MSButtonNodeStateHidden
            }
        }
        
        _ = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        
        // here
        /* Grab reference to our SpriteKit view */
        _ = self.view as SKView!
        
        
        /* Ensure correct aspect mode */
        //scene.scaleMode = .AspectFillscoreLabel
        // somthing here is wrong
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        scoreLabel.text = String("\(score)")
        
        
    }
    
    func createNewObstical(distanceFromLast: CGFloat) {
        var newObstacle: MSReferenceNodeShape!
        
        let randomScene = Int(arc4random_uniform(4))
        print(randomScene)
        if randomScene == 0 {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType1", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 1 {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType2", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 2 {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType3", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else if randomScene == 3 {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType4", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        } else  {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType5", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        }
        
        
        let colorOrder = Int(arc4random_uniform(3))
        if colorOrder == 0 {
            newObstacle.SquareType1.color = colors[0]!
            newObstacle.SquareType1.name = "correctblock"
            newObstacle.SquareType2.color = colors[1]!
            newObstacle.SquareType2.name = "wrong"
            newObstacle.triangleType1.color = colors[0]!
            newObstacle.triangleType1.name = "wrong"
            newObstacle.triangleType2.color = colors[1]!
            newObstacle.triangleType2.name = "correctblock"
            
        } else if colorOrder == 1 {
            newObstacle.SquareType1.color = colors[1]!
            newObstacle.SquareType1.name = "wrong"
            newObstacle.SquareType2.color = colors[0]!
            newObstacle.SquareType2.name = "correctblock"
            newObstacle.triangleType1.color = colors[1]!
            newObstacle.triangleType1.name = "correctblock"
            newObstacle.triangleType2.color = colors[0]!
            newObstacle.triangleType2.name = "wrong"
           
        } else if colorOrder == 2 {
            newObstacle.SquareType1.color = colors[0]!
            newObstacle.SquareType1.name = "correctblock"
            newObstacle.SquareType2.color = colors[1]!
            newObstacle.SquareType2.name = "wrong"
            newObstacle.triangleType1.color = colors[1]!
            newObstacle.triangleType1.name = "correctblock"
            newObstacle.triangleType2.color = colors[0]!
            newObstacle.triangleType2.name = "wrong"

            
        } else if colorOrder == 3 {
            newObstacle.SquareType1.color = colors[1]!
            newObstacle.SquareType1.name = "wrong"
            newObstacle.SquareType2.color = colors[0]!
            newObstacle.SquareType2.name = "correctblock"
            newObstacle.triangleType1.color = colors[0]!
            newObstacle.triangleType1.name = "wrong"
            newObstacle.triangleType2.color = colors[1]!
            newObstacle.triangleType2.name = "correctblock"
            
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
        for obstacle in obstacleLayer.children as! [MSReferenceNodeShape] {
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            if obstaclePosition.x < -350 {
                // print(obstaclePosition)
                if obstacle.SquareType1.name == "correctblock" || obstacle.SquareType2.name == "correctblock" || obstacle.triangleType1.name == "correctblock" || obstacle.triangleType2.name == "correctblock" {
                    
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
            colors[0] = SKColor(red: 255/255, green: 189/255, blue: 219/255, alpha: 1.0)
            colors[1] = SKColor(red: 178/255, green: 222/255, blue: 225/255, alpha: 1.0)
            
        } else if colorOrder == 1 {
            colors[0] = SKColor(red: 178/255, green: 222/255, blue: 225/255, alpha: 1.0)
            colors[1] = SKColor(red: 255/255, green: 189/255, blue: 219/255, alpha: 1.0)

            
        } else if colorOrder == 2 {
            colors[0] = SKColor(red: 185/255, green: 206/255, blue: 251/255, alpha: 1.0)
            colors[1] = SKColor(red: 255/255, green: 237/255, blue: 180/255, alpha: 1.0)
            
        } else  {
            colors[0] = SKColor(red: 255/255, green: 237/255, blue: 180/255, alpha: 1.0)
            colors[1] = SKColor(red: 185/255, green: 206/255, blue: 251/255, alpha: 1.0)
            
        }
        
    }
    
}

