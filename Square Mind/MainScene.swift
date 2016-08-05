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
    var title: SKLabelNode!
    var musicOn: MSButtonNode!
    var musicOff: MSButtonNode!
    var TriangleAndSquare: MSButtonNode!
    var EasyLevelButton: MSButtonNode!
    var HardLevelButton: MSButtonNode!
    var lableButtonForEasy: SKLabelNode!
    var settingsButton: MSButtonNode!
    var xoutofsettings: MSButtonNode!
    var crownScores: MSButtonNode!
    var highScoreLable: SKLabelNode!
    var EasyHSL: SKLabelNode!
    var EasyHS: SKLabelNode!
    var mediumHSL: SKLabelNode!
    var mediumHS: SKLabelNode!
    var hardHSL: SKLabelNode!
    var hardHS: SKLabelNode!
    var challengeHSL: SKLabelNode!
    var challengeHS: SKLabelNode!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        TriangleAndSquare = self.childNodeWithName("TriangleAndSquare") as! MSButtonNode
        quetionmark = self.childNodeWithName("quetionmark") as! MSButtonNode
        EasyLevelButton = self.childNodeWithName("EasyLevelButton") as! MSButtonNode
        HardLevelButton = self.childNodeWithName("HardLevelButton") as! MSButtonNode
        settingsButton = self.childNodeWithName("settingsButton") as! MSButtonNode
        xoutofsettings = self.childNodeWithName("xoutofsettings") as! MSButtonNode
        crownScores = self.childNodeWithName("crownScores") as! MSButtonNode
        
        /* Set UI connections */
        buttonPlay1 = self.childNodeWithName("buttonPlay") as! MSButtonNode
        text1 = self.childNodeWithName("text1") as! SKLabelNode
        text2 = self.childNodeWithName("text2") as! SKLabelNode
        text3 = self.childNodeWithName("text3") as! SKLabelNode
        text4 = self.childNodeWithName("text4") as! SKLabelNode
        text5 = self.childNodeWithName("text5") as! SKLabelNode
        text6 = self.childNodeWithName("text6") as! SKLabelNode
        text7 = self.childNodeWithName("text7") as! SKLabelNode
        text8 = self.childNodeWithName("text8") as! SKLabelNode
        text9 = self.childNodeWithName("text9") as! SKLabelNode
        title = self.childNodeWithName("title") as! SKLabelNode
        musicOn = self.childNodeWithName("musicOn") as! MSButtonNode
        musicOff = self.childNodeWithName("musicOff") as! MSButtonNode
        highScoreLable = self.childNodeWithName("highScoreLable") as! SKLabelNode
        EasyHSL = self.childNodeWithName("EasyHSL") as! SKLabelNode
        EasyHS = self.childNodeWithName("EasyHS") as! SKLabelNode
        mediumHSL = self.childNodeWithName("mediumHSL") as! SKLabelNode
        mediumHS = self.childNodeWithName("mediumHS") as! SKLabelNode
        hardHSL = self.childNodeWithName("hardHSL") as! SKLabelNode
        hardHS = self.childNodeWithName("hardHS") as! SKLabelNode
        challengeHSL = self.childNodeWithName("challengeHSL") as! SKLabelNode
        challengeHS = self.childNodeWithName("challengeHS") as! SKLabelNode
        
        highScoreLable.hidden = true
        EasyHSL.hidden = true
        EasyHS.hidden = true
        mediumHSL.hidden = true
        mediumHS.hidden = true
        hardHSL.hidden = true
        hardHS.hidden = true
        challengeHSL.hidden = true
        challengeHS.hidden = true
        crownScores.hidden = true
        quetionmark.hidden = true
        xoutofsettings.hidden = true
        musicOff.hidden = true
        musicOn.hidden = true
        text1.hidden = true
        text2.hidden = true
        text3.hidden = true
        text4.hidden = true
        text5.hidden = true
        text6.hidden = true
        text7.hidden = true
        text8.hidden = true
        text9.hidden = true
        settingsButton.selectedHandler = {
            self.mediumHS.text = "\(self.gameManager.highScore)"
            self.EasyHS.text = "\(self.gameManager.highScoreLevel1)"
            self.hardHS.text = "\(self.gameManager.highScoreLevel3)"
            self.challengeHS.text = "\(self.gameManager.highScoreShape)"
            self.highScoreLable.hidden = false
            self.EasyHSL.hidden = false
            self.EasyHS.hidden = false
            self.mediumHSL.hidden = false
            self.mediumHS.hidden = false
            self.hardHSL.hidden = false
            self.hardHS.hidden = false
            self.challengeHSL.hidden = false
            self.challengeHS.hidden = false
            self.crownScores.hidden = false
            self.title.hidden = true
            self.settingsButton.hidden = true
            self.EasyLevelButton.hidden = true
            self.HardLevelButton.hidden = true
            self.TriangleAndSquare.hidden = true
            self.buttonPlay1.hidden = true
            self.xoutofsettings.hidden  = false
            self.quetionmark.hidden = false
            
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
            self.crownScores.selectedHandler = {
                if self.highScoreLable.hidden == true {
                    self.text1.hidden = true
                    self.text2.hidden = true
                    self.text3.hidden = true
                    self.text4.hidden = true
                    self.text5.hidden = true
                    self.text6.hidden = true
                    self.text7.hidden = true
                    self.text8.hidden = true
                    self.text9.hidden = true
                    self.highScoreLable.hidden = false
                    self.EasyHSL.hidden = false
                    self.EasyHS.hidden = false
                    self.mediumHSL.hidden = false
                    self.mediumHS.hidden = false
                    self.hardHSL.hidden = false
                    self.hardHS.hidden = false
                    self.challengeHSL.hidden = false
                    self.challengeHS.hidden = false
                
                }
            }
            
            self.quetionmark.selectedHandler = {
                if self.text1.hidden == true {
                    self.highScoreLable.hidden = true
                    self.EasyHSL.hidden = true
                    self.EasyHS.hidden = true
                    self.mediumHSL.hidden = true
                    self.mediumHS.hidden = true
                    self.hardHSL.hidden = true
                    self.hardHS.hidden = true
                    self.challengeHSL.hidden = true
                    self.challengeHS.hidden = true
                    self.text1.hidden = false
                    self.text2.hidden = false
                    self.text3.hidden = false
                    self.text4.hidden = false
                    self.text5.hidden = false
                    self.text6.hidden = false
                    self.text7.hidden = false
                    self.text8.hidden = false
                    self.text9.hidden = false
                } 
            }
            self.xoutofsettings.selectedHandler = {
                self.highScoreLable.hidden = true
                self.EasyHSL.hidden = true
                self.EasyHS.hidden = true
                self.mediumHSL.hidden = true
                self.mediumHS.hidden = true
                self.hardHSL.hidden = true
                self.hardHS.hidden = true
                self.challengeHSL.hidden = true
                self.challengeHS.hidden = true
                self.text1.hidden = true
                self.text2.hidden = true
                self.text3.hidden = true
                self.text4.hidden = true
                self.text5.hidden = true
                self.text6.hidden = true
                self.text7.hidden = true
                self.text8.hidden = true
                self.text9.hidden = true
                self.title.hidden = false
                self.settingsButton.hidden = false
                self.EasyLevelButton.hidden = false
                self.HardLevelButton.hidden = false
                self.TriangleAndSquare.hidden = false
                self.buttonPlay1.hidden = false
                self.quetionmark.hidden = true
                self.xoutofsettings.hidden = true
                self.musicOff.hidden = true
                self.musicOn.hidden = true
                self.crownScores.hidden = true
            }
        }
        
        HardLevelButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = HardLevel(fileNamed:"HardLevel") as HardLevel!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.presentScene(scene)
            
        }
        
        TriangleAndSquare.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.presentScene(scene)
        }
        
        buttonPlay1.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene1(fileNamed:"GameScene1") as GameScene1!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.presentScene(scene)
        }
        
        EasyLevelButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = EasyLevel(fileNamed:"EasyLevel") as EasyLevel!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.presentScene(scene)
        }
    }
}
