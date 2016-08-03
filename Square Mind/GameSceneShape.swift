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
    var highscoreput: SKLabelNode!
    var Finalscore: SKLabelNode!
    var endOfGameButtonRestart: MSButtonNode!
    var scrollSpeed: CGFloat = 170
    var obstacleLayer: SKNode!
    let fixedDelta: CFTimeInterval = 1.0/60.0
    var duringGameButtonRestart: MSButtonNode!
    var spawnTimer: CFTimeInterval = 0
    var spawnTimerFixed: CFTimeInterval = 7.0
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
    var musicOn: MSButtonNode!
    var musicOff: MSButtonNode!
    var PauseMenuScore: SKLabelNode!
    
    var gameState: GameSceneShapeState = .Active
    
    func didBeginContact() {
        /* when game is over */
        if gameManager.highScoreShape < score {
            let partical = SKEmitterNode(fileNamed: "beathighscore")!
            partical.position.x = 0
            partical.position.y = 0
            partical.numParticlesToEmit = 600
            addChild(partical)
            gameManager.highScoreShape = score
        }
        if self.gameManager.mute == true {
            self.musicOn.hidden = true
            self.musicOff.hidden = false
        } else if self.gameManager.mute == false {
            self.musicOn.hidden = false
            self.musicOff.hidden = true
        }
        self.musicOn.selectedHandler = {
            self.gameManager.mute = true
            self.musicOff.hidden = false
            self.musicOn.hidden = true
        }
        self.musicOff.selectedHandler = {
            self.gameManager.mute = false
            self.musicOff.hidden = true
            self.musicOn.hidden = false
        }
        pauseButton.hidden = true
        homebutton.hidden = false
        highscoreput.hidden = false
        highscoreput.text = "\(gameManager.highScoreShape)"
        highscorelable.hidden = false
        Finalscore.hidden = false
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
            let location  = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "wrong"  {
                lives -= 1
                if gameManager.mute == false {
                    let faileffect = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
                    self.runAction(faileffect)
                }
                
                let wrongpt1 = SKEmitterNode(fileNamed: "wrongpt1")!
                let wrongpt2 = SKEmitterNode(fileNamed: "wrongpt2")!
                let wrongpt3 = SKEmitterNode(fileNamed: "wrongpt3")!
                let wrongpt4 = SKEmitterNode(fileNamed: "wrongpt4")!
                
                wrongpt1.position.x = 20
                wrongpt1.position.y = 10
                wrongpt2.position.x = 20
                wrongpt2.position.y = 10
                wrongpt3.position.x = 290
                wrongpt3.position.y = 100
                wrongpt4.position.x = 150
                wrongpt4.position.y = 470
                
                wrongpt1.numParticlesToEmit = 75
                wrongpt2.numParticlesToEmit = 75
                wrongpt4.numParticlesToEmit = 75
                wrongpt3.numParticlesToEmit = 75
                
                addChild(wrongpt1)
                addChild(wrongpt2)
                addChild(wrongpt4)
                addChild(wrongpt3)
                
            } else if node.name == "correctblock" {
                score += 1
                /* Load our particle effect */
                let partical = SKEmitterNode(fileNamed: "CorrectColor")!
                partical.position = convertPoint(location, fromNode: self)
                partical.numParticlesToEmit = 75
                addChild(partical)
                
                if gameManager.mute == false {
                    let correctsound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
                    self.runAction(correctsound)
                }
                
                scoreLabel.text = String("\(score)")
                node.name = "tappedblock"
                node.hidden = true
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
         if score <= 10{
            scrollSpeed = 240
        }else if score <= 25 {
            scrollSpeed = 270
        }else if score <= 75 {
            scrollSpeed = 300
        } else if score <= 100 {
            scrollSpeed = 330
        } else {
            scrollSpeed = 330
        
        }
    }
    
    
    func homeButtonSelected() {
        homebutton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.presentScene(scene)
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        homebutton = self.childNodeWithName("homebutton") as! MSButtonNode
        highscorelable = self.childNodeWithName("highscorelable") as! SKLabelNode
        highscoreput = self.childNodeWithName("//highscoreput") as! SKLabelNode
        Finalscore = self.childNodeWithName("Finalscore")as! SKLabelNode
        PauseMenuScore = self.childNodeWithName("PauseMenuScore")as! SKLabelNode
        playButton = self.childNodeWithName("//playButton") as! MSButtonNode
        pauseButton = self.childNodeWithName("//pauseButton") as! MSButtonNode
        musicOn = self.childNodeWithName("musicOn") as! MSButtonNode
        musicOff = self.childNodeWithName("musicOff") as! MSButtonNode
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        endOfGameButtonRestart = self.childNodeWithName("endOfGameButtonRestart") as! MSButtonNode
        duringGameButtonRestart = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        
        musicOn.hidden = true
        musicOff.hidden = true
        homebutton.hidden = true
        highscoreput.hidden = true
        highscorelable.hidden = true
        Finalscore.hidden = true
        PauseMenuScore.hidden = true
        playButton.hidden = true
        duringGameButtonRestart.hidden = true
        
        pickAColor()
        correctSquare = childNodeWithName("correctSquare") as! SKSpriteNode
        correctTriangle = childNodeWithName("correctTriangle") as! SKSpriteNode
        incorrectTriangle = childNodeWithName("incorrectTriangle") as! SKSpriteNode
        incorrectSquare = childNodeWithName("incorrectSquare") as! SKSpriteNode
        
        correctSquare.color = colors[0]!
        correctTriangle.color = colors[1]!
        incorrectTriangle.color = colors[0]!
        incorrectSquare.color = colors[1]!
        
        
        createNewObstical(1700)
        
        endOfGameButtonRestart.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            
        }
        endOfGameButtonRestart.hidden = true
        
        pauseButton.selectedHandler = {
            /*pause button */
            self.scoreLabel.position.x = 154
            self.scoreLabel.position.y = 280
            self.gameState = .Pause
            self.PauseMenuScore.hidden = false
            self.scrollSpeed = 0
            if self.gameManager.mute == true {
                self.musicOn.hidden = true
                self.musicOff.hidden = false
            } else if self.gameManager.mute == false {
                self.musicOn.hidden = false
                self.musicOff.hidden = true
            }
            self.musicOn.selectedHandler = {
                self.gameManager.mute = true
                self.musicOff.hidden = false
                self.musicOn.hidden = true
            }
            self.musicOff.selectedHandler = {
                self.gameManager.mute = false
                self.musicOff.hidden = true
                self.musicOn.hidden = false
            }
            self.pauseButton.hidden = true
            self.duringGameButtonRestart.hidden = false
            self.homebutton.hidden = false
            self.playButton.hidden = false
            self.playButton.selectedHandler = {
                /* play buttton */
                self.PauseMenuScore.hidden = true
                self.scoreLabel.position.x = 72
                self.scoreLabel.position.y = 432
                self.musicOff.hidden = true
                self.musicOn.hidden = true
                self.pauseButton.hidden = false
                self.duringGameButtonRestart.hidden = true
                self.homebutton.hidden = true
                self.playButton.hidden = true
                self.gameState = .Active
                self.increaseSpeed()
            }
            
            self.duringGameButtonRestart.selectedHandler = {
                /* restar button */
                let skView = self.view as SKView!
                let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
                scene.scaleMode = .AspectFill
                skView.presentScene(scene)
                
                self.duringGameButtonRestart.state = .MSButtonNodeStateHidden
            }
        }
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        scoreLabel.text = String("\(score)")
    }
    
    func createNewObstical(distanceFromLast: CGFloat) {
        var newObstacle: MSReferenceNodeShape!
        
        let randomScene = Int(arc4random_uniform(5))
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
        } else if  randomScene == 4 {
            let resourcePath = NSBundle.mainBundle().pathForResource("ShapeSceneType5", ofType: "sks")
            newObstacle = MSReferenceNodeShape(URL: NSURL (fileURLWithPath: resourcePath!))
            obstacleLayer.addChild(newObstacle)
        }
        
        let colorOrder = Int(arc4random_uniform(4))
        if colorOrder == 0 {
                newObstacle.triangleType1.color = colors[0]!
                newObstacle.triangleType1.name = "wrong"
                newObstacle.NodeTypeShapeColor1.color = colors[0]!
                newObstacle.NodeTypeShapeColor1.name = "correctblock"
        } else if colorOrder == 1 {
                newObstacle.triangleType1.color = colors[1]!
                newObstacle.triangleType1.name = "correctblock"
                newObstacle.NodeTypeShapeColor1.color = colors[1]!
                newObstacle.NodeTypeShapeColor1.name = "wrong"
        
        } else if colorOrder == 2 {
            newObstacle.triangleType1.color = colors[0]!
            newObstacle.triangleType1.name = "wrong"
            newObstacle.NodeTypeShapeColor1.color = colors[1]!
            newObstacle.NodeTypeShapeColor1.name = "wrong"
        } else if colorOrder == 3 {
            newObstacle.triangleType1.color = colors[1]!
            newObstacle.triangleType1.name = "correctblock"
            newObstacle.NodeTypeShapeColor1.color = colors[0]!
            newObstacle.NodeTypeShapeColor1.name = "correctblock"
            
        }
        
        let Position = CGPointMake(distanceFromLast, 0)
        newObstacle.position = self.convertPoint(Position, toNode: obstacleLayer)
    }
    
    
    func updateObstacles() {
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            /* Check if obstacle has left the scene */
            if spawnTimer >= spawnTimerFixed /*change to timer*/{
                createNewObstical(360)
                spawnTimer = 0
                if score <= 10 {
                    spawnTimerFixed = 0.94
                } else if score <= 25 {
                    spawnTimerFixed = 0.88
                } else if score <= 75 {
                    spawnTimerFixed = 0.82
                } else if score <= 100 {
                    spawnTimerFixed = 0.78
                } else {
                    spawnTimerFixed = 0.74
                
                }
            }
            if obstaclePosition.x < -144 {
                obstacle.removeFromParent()
            }
            
        }
    }
    
        func mustTap() {
            for obstacle in obstacleLayer.children as! [MSReferenceNodeShape] {
                let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
                if obstaclePosition.x < -140 {
                    
                    if obstacle.NodeTypeShapeColor1.name == "correctblock" || obstacle.triangleType1.name == "correctblock"  {
                        
                        let wrongpt1 = SKEmitterNode(fileNamed: "wrongpt1")!
                        let wrongpt2 = SKEmitterNode(fileNamed: "wrongpt2")!
                        let wrongpt3 = SKEmitterNode(fileNamed: "wrongpt3")!
                        let wrongpt4 = SKEmitterNode(fileNamed: "wrongpt4")!
                        
                        wrongpt1.position.x = 20
                        wrongpt1.position.y = 10
                        wrongpt2.position.x = 20
                        wrongpt2.position.y = 10
                        wrongpt3.position.x = 290
                        wrongpt3.position.y = 100
                        wrongpt4.position.x = 150
                        wrongpt4.position.y = 470
                        
                        wrongpt1.numParticlesToEmit = 75
                        wrongpt2.numParticlesToEmit = 75
                        wrongpt4.numParticlesToEmit = 75
                        wrongpt3.numParticlesToEmit = 75
                        
                        addChild(wrongpt1)
                        addChild(wrongpt2)
                        addChild(wrongpt4)
                        addChild(wrongpt3)
                        
                        lives -= 1
                        if gameManager.mute == false {
                            let faileffect = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
                            self.runAction(faileffect)
                        }
                        print("you lost a life now\(lives)")
                        obstacle.removeFromParent()
                    }
                }
            }
        }
        
        override func update(currentTime: CFTimeInterval) {
            homeButtonSelected()
            if gameState != .Active { return }
            mustTap()
            increaseSpeed()
            obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
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