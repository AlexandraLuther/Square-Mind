//
//  MainScene.Swift
//  Square Mind
//
//  Created by Alex Luther on 7/26/16.
//  Copyright © 2016 Alex Luther. All rights reserved.
//

import SpriteKit
import GameKit

class MainScene: SKScene, SKPhysicsContactDelegate, GKGameCenterControllerDelegate {
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
    var text10: SKLabelNode!
    var text11: SKLabelNode!
    var text12: SKLabelNode!
    var text13: SKLabelNode!
    var text14: SKLabelNode!
    var text15: SKLabelNode!
    var text16: SKLabelNode!
    var text17: SKLabelNode!
    var text18: SKLabelNode!
    var text1g: SKLabelNode!
    var text2g: SKLabelNode!
    var text3g: SKLabelNode!
    var text4g: SKLabelNode!
    var text5g: SKLabelNode!
    var text6g: SKLabelNode!
    var text7g: SKLabelNode!
    var text8g: SKLabelNode!
    var text9g: SKLabelNode!
    var text10g: SKLabelNode!
    var text11g: SKLabelNode!
    var text12g: SKLabelNode!
    var text13g: SKLabelNode!
    var text14g: SKLabelNode!
    var text15g: SKLabelNode!
    var text16g: SKLabelNode!
    var text17g: SKLabelNode!
    var text18g: SKLabelNode!
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
    var gameCenter: MSButtonNode!
    
    func showLeader() {
        let viewControllerVar = self.view?.window?.rootViewController
        let gKGCViewController = GKGameCenterViewController()
        gKGCViewController.gameCenterDelegate = self
        viewControllerVar?.presentViewController(gKGCViewController, animated: true, completion: nil)
    }
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
        gameCenter = self.childNodeWithName("gameCenter") as! MSButtonNode
        text1 = self.childNodeWithName("text1") as! SKLabelNode
        text2 = self.childNodeWithName("text2") as! SKLabelNode
        text3 = self.childNodeWithName("text3") as! SKLabelNode
        text4 = self.childNodeWithName("text4") as! SKLabelNode
        text5 = self.childNodeWithName("text5") as! SKLabelNode
        text6 = self.childNodeWithName("text6") as! SKLabelNode
        text7 = self.childNodeWithName("text7") as! SKLabelNode
        text8 = self.childNodeWithName("text8") as! SKLabelNode
        text9 = self.childNodeWithName("text9") as! SKLabelNode
        text10 = self.childNodeWithName("text10") as! SKLabelNode
        text11 = self.childNodeWithName("text11") as! SKLabelNode
        text12 = self.childNodeWithName("text12") as! SKLabelNode
        text13 = self.childNodeWithName("text13") as! SKLabelNode
        text14 = self.childNodeWithName("text14") as! SKLabelNode
        text15 = self.childNodeWithName("text15") as! SKLabelNode
        text16 = self.childNodeWithName("text16") as! SKLabelNode
        text17 = self.childNodeWithName("text17") as! SKLabelNode
        text18 = self.childNodeWithName("text18") as! SKLabelNode
        text1g = self.childNodeWithName("text1g") as! SKLabelNode
        text2g = self.childNodeWithName("text2g") as! SKLabelNode
        text3g = self.childNodeWithName("text3g") as! SKLabelNode
        text4g = self.childNodeWithName("text4g") as! SKLabelNode
        text5g = self.childNodeWithName("text5g") as! SKLabelNode
        text6g = self.childNodeWithName("text6g") as! SKLabelNode
        text7g = self.childNodeWithName("text7g") as! SKLabelNode
        text8g = self.childNodeWithName("text8g") as! SKLabelNode
        text9g = self.childNodeWithName("text9g") as! SKLabelNode
        text10g = self.childNodeWithName("text10g") as! SKLabelNode
        text11g = self.childNodeWithName("text11g") as! SKLabelNode
        text12g = self.childNodeWithName("text12g") as! SKLabelNode
        text13g = self.childNodeWithName("text13g") as! SKLabelNode
        text14g = self.childNodeWithName("text14g") as! SKLabelNode
        text15g = self.childNodeWithName("text15g") as! SKLabelNode
        text16g = self.childNodeWithName("text16") as! SKLabelNode
        text17g = self.childNodeWithName("text17g") as! SKLabelNode
        text18g = self.childNodeWithName("text18g") as! SKLabelNode
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
        
        gameCenter.hidden = true
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
        text10.hidden = true
        text11.hidden = true
        text12.hidden = true
        text13.hidden = true
        text14.hidden = true
        text15.hidden = true
        text16.hidden = true
        text17.hidden = true
        text18.hidden = true
        text1g.hidden = true
        text2g.hidden = true
        text3g.hidden = true
        text4g.hidden = true
        text5g.hidden = true
        text6g.hidden = true
        text7g.hidden = true
        text8g.hidden = true
        text9g.hidden = true
        text10g.hidden = true
        text11g.hidden = true
        text12g.hidden = true
        text13g.hidden = true
        text14g.hidden = true
        text15g.hidden = true
        text16g.hidden = true
        text17g.hidden = true
        text18g.hidden = true
        text2.position.x = 30
        text2g.position.x = 30.5
        text4g.position.x = 30.5
        text4.position.x = 30
        text8g.position.x = 30.5
        text8.position.x = 30
        text11.position.x = 30
        text11g.position.x = 30.5
        text13.position.x = 30
        text13g.position.x = 30.5
        text17.position.x = 30
        text17g.position.x = 30.5
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
            self.gameCenter.hidden = false
            
            self.gameCenter.selectedHandler = {
                self.showLeader()
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
                    self.text10.hidden = true
                    self.text11.hidden = true
                    self.text12.hidden = true
                    self.text13.hidden = true
                    self.text14.hidden = true
                    self.text15.hidden = true
                    self.text16.hidden = true
                    self.text17.hidden = true
                    self.text18.hidden = true
                    self.text1g.hidden = true
                    self.text2g.hidden = true
                    self.text3g.hidden = true
                    self.text4g.hidden = true
                    self.text5g.hidden = true
                    self.text6g.hidden = true
                    self.text7g.hidden = true
                    self.text8g.hidden = true
                    self.text9g.hidden = true
                    self.text10g.hidden = true
                    self.text11g.hidden = true
                    self.text12g.hidden = true
                    self.text13g.hidden = true
                    self.text14g.hidden = true
                    self.text15g.hidden = true
                    self.text16g.hidden = true
                    self.text17g.hidden = true
                    self.text18g.hidden = true
                    self.gameCenter.hidden = false
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
                    self.gameCenter.hidden = true
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
                    self.text10.hidden = false
                    self.text11.hidden = false
                    self.text12.hidden = false
                    self.text13.hidden = false
                    self.text14.hidden = false
                    self.text15.hidden = false
                    self.text16.hidden = false
                    self.text17.hidden = false
                    self.text18.hidden = false
                    self.text1g.hidden = false
                    self.text2g.hidden = false
                    self.text3g.hidden = false
                    self.text4g.hidden = false
                    self.text5g.hidden = false
                    self.text6g.hidden = false
                    self.text7g.hidden = false
                    self.text8g.hidden = false
                    self.text9g.hidden = false
                    self.text10g.hidden = false
                    self.text11g.hidden = false
                    self.text12g.hidden = false
                    self.text13g.hidden = false
                    self.text14g.hidden = false
                    self.text15g.hidden = false
                    self.text16g.hidden = false
                    self.text17g.hidden = false
                    self.text18g.hidden = false
                } 
            }
            self.xoutofsettings.selectedHandler = {
                self.gameCenter.hidden = true
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
                self.text10.hidden = true
                self.text11.hidden = true
                self.text12.hidden = true
                self.text13.hidden = true
                self.text14.hidden = true
                self.text15.hidden = true
                self.text16.hidden = true
                self.text17.hidden = true
                self.text18.hidden = true
                self.text1g.hidden = true
                self.text2g.hidden = true
                self.text3g.hidden = true
                self.text4g.hidden = true
                self.text5g.hidden = true
                self.text6g.hidden = true
                self.text7g.hidden = true
                self.text8g.hidden = true
                self.text9g.hidden = true
                self.text10g.hidden = true
                self.text11g.hidden = true
                self.text12g.hidden = true
                self.text13g.hidden = true
                self.text14g.hidden = true
                self.text15g.hidden = true
                self.text16g.hidden = true
                self.text17g.hidden = true
                self.text18g.hidden = true
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
            skView.showsFPS = false
            skView.presentScene(scene)
            
        }
        
        TriangleAndSquare.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameSceneShape(fileNamed:"GameSceneShape") as GameSceneShape!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = false
            skView.presentScene(scene)
        }
        
        buttonPlay1.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene1(fileNamed:"GameScene1") as GameScene1!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = false
            skView.presentScene(scene)
        }
        
        EasyLevelButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = EasyLevel(fileNamed:"EasyLevel") as EasyLevel!
            scene.scaleMode = .AspectFill
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = false
            skView.presentScene(scene)
        }
    }
}
