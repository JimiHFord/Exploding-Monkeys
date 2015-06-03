//
//  GameViewController.swift
//  ExplodingMonkeys
//
//  Created by James Ford on 6/2/15.
//  Copyright (c) 2015 JWorks. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    var currentGame: GameScene!
    
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            currentGame = scene
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func angleChanged(sender: UISlider!) {
        angleLabel.text = "\(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(sender: UISlider!) {
        velocityLabel.text = "\(Int(velocitySlider.value))/250"
    }
    
    @IBAction func launch(sender: AnyObject) {
        angleSlider.hidden = true
        angleLabel.hidden = true
        velocitySlider.hidden = true
        velocityLabel.hidden = true
        launchButton.hidden = true
        playerLabel.hidden = true
        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func setPlayerNumber(number: Int) {
        if number == 1 {
            playerLabel.text = "<<< PLAYER ONE"
        } else {
            playerLabel.text = "PLAYER TWO >>>"
        }
        angleSlider.hidden = false
        angleLabel.hidden = false
        velocitySlider.hidden = false
        velocityLabel.hidden = false
        launchButton.hidden = false
        playerLabel.hidden = false
    }
}
