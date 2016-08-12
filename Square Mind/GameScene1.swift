//
//  GameScene1.swift
//  Square Mind
//
//  Created by Alex Luther on 7/12/16.
//  Copyright (c) 2016 Alex Luther. All rights reserved.
//

import SpriteKit
import Mixpanel
import GameKit

enum GameScene1State {
    case Active, GameOver, Pause
}

class GameScene1: SKScene, SKPhysicsContactDelegate {
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
    var pauseButton: MSButtonNode!
    var playButton: MSButtonNode!
    var musicOn: MSButtonNode!
    var musicOff: MSButtonNode!
    var PauseMenuScore: SKLabelNode!
    var scoreToHighScorePt1: SKLabelNode!
    var scoreToHighScorePt2: SKLabelNode!
    
    var gameState: GameScene1State = .Active
    
    func didBeginContact() {
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Level Played", properties: ["Level Type": 2])
        // Show rewarded video pre-roll message and video ad at location MainMenu. See Chartboost.h for available location options.
        if gameManager.highScore < score {
            let partical = SKEmitterNode(fileNamed: "beathighscore")!
            partical.position.x = 0
            partical.position.y = 0
            partical.numParticlesToEmit = 600
            addChild(partical)
            gameManager.highScore = score
        
            let SquareMindMediumLevelHighScore = "SquareMindMediumLevelHighScore"
            let sScore = GKScore(leaderboardIdentifier: SquareMindMediumLevelHighScore)
            sScore.value = Int64(score)
            
            GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("Score submitted")
                    
                }
            })

        } else {
            Chartboost.showInterstitial(CBLocationHomeScreen)
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
        highscoreput.text = "\(gameManager.highScore)"
        highscorelable.hidden = false
        Finalscore.hidden = false
        duringGameButtonRestart.hidden = true
        scoreLabel.position.x = 154
        scoreLabel.position.y = 235
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
            print(node.name)
            
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
                /* location of border of wrong move */
                wrongpt1.position.x = 20
                wrongpt1.position.y = 10
                wrongpt2.position.x = 20
                wrongpt2.position.y = 10
                wrongpt3.position.x = 290
                wrongpt3.position.y = 100
                wrongpt4.position.x = 150
                wrongpt4.position.y = 470
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
                /* Restrict total particles to reduce runtime of particle */
                partical.numParticlesToEmit = 75
                /* Add particles to scene */
                addChild(partical)
                /* sound if mute is not turned on */
                if gameManager.mute == false {
                    let correctsound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
                    self.runAction(correctsound)
                }
                if score == gameManager.highScore + 1 {
                    let partical = SKEmitterNode(fileNamed: "newHighScore")!
                    /* Convert node location (currently inside Level 1, to scene space) */
                    partical.position.x = 76
                    partical.position.y = 445
                    /* Restrict total particles to reduce runtime of particle */
                    partical.numParticlesToEmit = 15
                    /* Add particles to scene */
                    addChild(partical)
                }
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
        if score <= 10 {
            scrollSpeed = 170
        } else if score <= 25{
            scrollSpeed = 210
        } else if score <= 50 {
            scrollSpeed = 240
        } else if score <= 75 {
            scrollSpeed = 270
        } else if score <= 100 {
            scrollSpeed = 300
        } else if score <= 150 {
            scrollSpeed = 330
        } else {
            scrollSpeed = 360
        }
    }
    
    
    func homeButtonSelected() {
        homebutton.selectedHandler = {
            
            let skView = self.view as SKView!
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = false
            skView.showsFPS = false
            skView.presentScene(scene)
        }
        
    }
    
    
    override func didMoveToView(view: SKView) {
        homebutton = self.childNodeWithName("homebutton") as! MSButtonNode
        highscorelable = self.childNodeWithName("highscorelable") as! SKLabelNode
        highscoreput = self.childNodeWithName("highscore") as! SKLabelNode
        Finalscore = self.childNodeWithName("Finalscore")as! SKLabelNode
        PauseMenuScore = self.childNodeWithName("PauseMenuScore")as! SKLabelNode
        playButton = self.childNodeWithName("//playButton") as! MSButtonNode
        pauseButton = self.childNodeWithName("//pauseButton") as! MSButtonNode
        musicOn = self.childNodeWithName("musicOn") as! MSButtonNode
        musicOff = self.childNodeWithName("musicOff") as! MSButtonNode
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        endOfGameButtonRestart = self.childNodeWithName("endOfGameButtonRestart") as! MSButtonNode
        duringGameButtonRestart = self.childNodeWithName("duringGameButtonRestart") as! MSButtonNode
        scoreToHighScorePt1 = self.childNodeWithName("//scoreToHighScorePt1") as! SKLabelNode
        scoreToHighScorePt2 = self.childNodeWithName("//scoreToHighScorePt2") as! SKLabelNode
        
        scoreToHighScorePt1.hidden = true
        scoreToHighScorePt2.hidden = true
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
        // what shows up befor the game begings to show what color is right and what is wrong
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
        
        createNewObstical(1400)
        
        /* Setup restart button selection handler */
        endOfGameButtonRestart.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene1(fileNamed:"GameScene1") as GameScene1!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            }
        
        endOfGameButtonRestart.hidden = true
        
        pauseButton.selectedHandler = {
            /*pause button */
            self.gameState = .Pause
            self.scoreToHighScorePt1.hidden = false
            self.scoreToHighScorePt2.hidden = false
            if self.gameManager.highScore < self.score {
                self.scoreToHighScorePt1.text = "Your score is \(self.score - self.gameManager.highScore)"
                self.scoreToHighScorePt2.text = "above the preivios High Score!"
            } else {
                self.scoreToHighScorePt1.text = "You are \(self.gameManager.highScore - self.score + 1) away from"
                self.scoreToHighScorePt2.text = "getting the next high score"
            }
            self.scoreLabel.position.x = 154
            self.scoreLabel.position.y = 300
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
                /* play button */
                self.scoreToHighScorePt1.hidden = true
                self.scoreToHighScorePt2.hidden = true
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
                /* restart button */
                let skView = self.view as SKView!
                let scene = GameScene1(fileNamed:"GameScene1") as GameScene1!
                scene.scaleMode = .AspectFill
                skView.presentScene(scene)
                self.duringGameButtonRestart.state = .MSButtonNodeStateHidden
            }
        }
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        scoreLabel.text = String("\(score)")
    }
    
    
    func createNewObstical(distanceFromLast: CGFloat) {
        var newObstacle:MSReferenceNode!
        let randomScene = Int(arc4random_uniform(5))
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
        
        let colorOrder = Int(arc4random_uniform(5))
        if colorOrder == 0 {
            newObstacle.NodeTypeColor1.color = colors[0]!
            newObstacle.NodeTypeColor1.name = "correctblock"
        } else if colorOrder == 1 {
            newObstacle.NodeTypeColor1.color = colors[1]!
            newObstacle.NodeTypeColor1.name = "correctblock"
        } else if colorOrder == 2 {
            newObstacle.NodeTypeColor1.color = colors[2]!
            newObstacle.NodeTypeColor1.name = "correctblock"
        } else if colorOrder == 3 {
            newObstacle.NodeTypeColor1.color = colors[4]!
            newObstacle.NodeTypeColor1.name = "wrong"
        } else if colorOrder == 4 {
            newObstacle.NodeTypeColor1.color = colors[3]!
            newObstacle.NodeTypeColor1.name = "wrong"
        }
        /* y valuse can change */
        let Position = CGPointMake(distanceFromLast, 0)
        newObstacle.position = self.convertPoint(Position, toNode: obstacleLayer)
    }
    
    
    func updateObstacles() {
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            if spawnTimer >= spawnTimerFixed /*change to timer*/{
                createNewObstical(360)
                spawnTimer = 0
                if score <= 10 {
                    spawnTimerFixed = 0.54
                } else if score <= 25 {
                    spawnTimerFixed = 0.47
                } else if score <= 50 {
                    spawnTimerFixed = 0.44
                } else if score <= 75 {
                    spawnTimerFixed = 0.41
                } else if score <= 100 {
                    spawnTimerFixed = 0.39
                } else  {
                    spawnTimerFixed = 0.37
                }
            }
            /* Remove obstacle node from obstacle layer */
            if obstaclePosition.x <= -70 {
                obstacle.removeFromParent()
            }
        }
    }
    
    
    func mustTap() {
        for obstacle in obstacleLayer.children as! [MSReferenceNode] {
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            if obstaclePosition.x < -70 {
                // live was lost becouse it wasn't taped
                if obstacle.NodeTypeColor1.name == "correctblock" {
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
        /* Skip game update if game no longer active */
        if gameState != .Active { return }
        /* Called before each frame is rendered */
        increaseSpeed()
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        mustTap()
        updateObstacles()
        lossOfLives()
        spawnTimer += fixedDelta
    }
    
    
    var colors = [SKColor?](count: 6, repeatedValue: nil)
    func pickAColor() {
        
        let colorOrder = Int(arc4random_uniform(4))
        if colorOrder == 0 {
            colors[0] = SKColor(red: 152/255, green: 248/255, blue: 248/255, alpha: 1.0)
            colors[1] = SKColor(red: 176/255, green: 160/255, blue: 248/255, alpha: 1.0)
            colors[2] = SKColor(red: 196/255, green: 242/255, blue: 200/255, alpha: 1.0)
            colors[3] = SKColor(red: 239/255, green: 161/255, blue: 185/255, alpha: 1.0)
            colors[4] = SKColor(red: 252/255, green: 255/255, blue: 217/255, alpha: 1.0)
        } else if colorOrder == 1 {
            colors[0] = SKColor(red: 196/255, green: 242/255, blue: 200/255, alpha: 1.0)
            colors[1] = SKColor(red: 152/255, green: 248/255, blue: 248/255, alpha: 1.0)
            colors[2] = SKColor(red: 252/255, green: 255/255, blue: 217/255, alpha: 1.0)
            colors[3] = SKColor(red: 176/255, green: 160/255, blue: 248/255, alpha: 1.0)
            colors[4] = SKColor(red: 239/255, green: 161/255, blue: 185/255, alpha: 1.0)
        } else if colorOrder == 2 {
            colors[0] = SKColor(red: 176/255, green: 160/255, blue: 248/255, alpha: 1.0)
            colors[1] = SKColor(red: 252/255, green: 255/255, blue: 217/255, alpha: 1.0)
            colors[2] = SKColor(red: 239/255, green: 161/255, blue: 185/255, alpha: 1.0)
            colors[3] = SKColor(red: 152/255, green: 248/255, blue: 248/255, alpha: 1.0)
            colors[4] = SKColor(red: 196/255, green: 242/255, blue: 200/255, alpha: 1.0)
        } else  {
            colors[0] = SKColor(red: 252/255, green: 255/255, blue: 217/255, alpha: 1.0)
            colors[1] = SKColor(red: 239/255, green: 161/255, blue: 185/255, alpha: 1.0)
            colors[2] = SKColor(red: 152/255, green: 248/255, blue: 248/255, alpha: 1.0)
            colors[3] = SKColor(red: 196/255, green: 242/255, blue: 200/255, alpha: 1.0)
            colors[4] = SKColor(red: 176/255, green: 160/255, blue: 248/255, alpha: 1.0)
        }
    }
}