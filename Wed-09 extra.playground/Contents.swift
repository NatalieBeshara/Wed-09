

// Created on: 21-Nov-2018
// Created by: Natalie Beshara
// Created for: ICS3U
// This program is a SpriteKit template

// this will be commented out when code moved to Xcode
import PlaygroundSupport


import SpriteKit

class SplashScene: SKScene, SKPhysicsContactDelegate {
    let splashSceneBackground = SKSpriteNode(imageNamed: "splashSceneImage.png")
    let moveToNextSceneDelay = SKAction.wait(forDuration: 5.0)
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)
        
        splashSceneBackground.name = "Splash Scene Background"
        splashSceneBackground.position = CGPoint(x: frame.size.width/2, y: frame.size.height/3)
        splashSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(splashSceneBackground)
        
        splashSceneBackground.run(moveToNextSceneDelay) {
            
            let mainMenuScene = MainMenuScene(size: self.size)
            self.view!.presentScene(mainMenuScene)
        }
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        let mainMenuScene = MainMenuScene(size: self.size)
        self.view!.presentScene(mainMenuScene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
}
class MainMenuScene: SKScene, SKPhysicsContactDelegate {
    let startButton = SKSpriteNode(imageNamed: "IMG_4560.PNG")
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        
        startButton.position = CGPoint(x: (frame.size.width / 2), y: 100)
        startButton.name = "start button"
        self.addChild(startButton)
        startButton.setScale(0.65)
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
            let touch = touches as! Set<UITouch>
            let positionInScene = touch.first!.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let startButton = touchedNode.name {
                if startButton == "start button" {
                    let mainGameScene = MainGameScene(size: self.size)
                    self.view!.presentScene(mainGameScene)
                }
            }
            
        }

    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
}

class MainGameScene: SKScene, SKPhysicsContactDelegate {
    let ship = SKSpriteNode(imageNamed: "IMG_4449.PNG")
    let leftButton = SKSpriteNode(imageNamed:"IMG_4664.PNG")
    let rightButton = SKSpriteNode(imageNamed:"IMG_4663.PNG")
    let fireButton = SKSpriteNode(imageNamed: "redButton.png")
    
    var score = 0
    let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    var leftButtonPressed = false
    var rightButtonPressed = false
    var fireButtonPressed = false
    
    var missiles = [SKSpriteNode]()
    var aliens = [SKSpriteNode]()
    var alienAttackRate: Double = 1
    
    let collisionMissileCatergory: UInt32 = 1
    let collisionAlienCatergory: UInt32 = 2
    let collisionSpaceShipCatergory: UInt32 = 4
    
    
    func createAlien() {
        //
        
        let aSingleAlien = SKSpriteNode(imageNamed: "alien.png")
        aSingleAlien.name = "alien"
        aSingleAlien.physicsBody?.isDynamic = true
        aSingleAlien.physicsBody = SKPhysicsBody(texture: aSingleAlien.texture!, size: aSingleAlien.size)
        aSingleAlien.physicsBody?.affectedByGravity = false
        aSingleAlien.physicsBody?.usesPreciseCollisionDetection = true
        aSingleAlien.physicsBody?.categoryBitMask = collisionAlienCatergory
        aSingleAlien.physicsBody?.contactTestBitMask = collisionMissileCatergory
        aSingleAlien.physicsBody?.collisionBitMask = 0x0
        let alienStartPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        let alienEndPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        aSingleAlien.position = CGPoint(x: alienStartPositionX, y: Int(frame.size.height) + 100)
        let alienMove = SKAction.move(to: CGPoint(x: alienEndPositionX, y:  -100), duration: 4)
        aSingleAlien.run(alienMove)
        self.addChild(aSingleAlien)
        aliens.append(aSingleAlien)
    }
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        // turn on physics collision detection
        self.physicsWorld.contactDelegate =  self
        
        self.backgroundColor = SKColor(red: 0.00, green:0.15, blue:0.15, alpha: 1.0)
        
        ship.position = CGPoint(x: (frame.size.width / 2), y: 100)
        ship.name = "space ship"
        ship.physicsBody?.isDynamic = true
        ship.physicsBody = SKPhysicsBody(texture: ship.texture!, size: ship.size)
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.usesPreciseCollisionDetection = true
        ship.physicsBody?.categoryBitMask = collisionSpaceShipCatergory
        ship.physicsBody?.contactTestBitMask = collisionAlienCatergory
        ship.physicsBody?.collisionBitMask = 0x0
        self.addChild(ship)
        ship.setScale(0.65)
        
        leftButton.name = "left button"
        leftButton.position = CGPoint(x: 100, y: 100)
        leftButton.alpha = 0.5
        self.addChild(leftButton)
        leftButton.setScale(0.75)
        
        rightButton.name = "right button"
        rightButton.position = CGPoint(x: 300, y: 100)
        rightButton.alpha = 0.5
        self.addChild(rightButton)
        rightButton.setScale(0.75)
        
        fireButton.name = "fire button"
        fireButton.position = CGPoint(x: frame.size.width - 100, y: 100)
        fireButton.alpha = 0.5
        self.addChild(fireButton)
        rightButton.setScale(0.75)
        
        scoreLabel.position = CGPoint(x: frame.size.width/4, y: frame.size.height - 50)
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = "Score: \(score)"
        self.addChild(scoreLabel)
        scoreLabel.setScale(0.60)
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        if rightButtonPressed == true && ship.position.x <= (frame.size.width){
            var moveShipRight = SKAction.moveBy(x: 10, y: 0, duration : 0.1)
            ship.run(moveShipRight)
        }
            
        else if leftButtonPressed == true && ship.position.x >= 0 {
            var moveShipLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
            ship.run(moveShipLeft)     
            
        }
        
        let createAlienChance = Int(arc4random_uniform(120) + 1)
        if createAlienChance <= Int(alienAttackRate) {
            createAlien()
        }
        
        for aSingleMissile in missiles {
            if aSingleMissile.position.y > frame.size.height {
                aSingleMissile.removeFromParent()
                missiles.removeFirst()
            }
        }
        
        for aSingleAlien in aliens {
        if aSingleAlien.position.y <  -100{
        aSingleAlien.removeFromParent()
        aliens.removeFirst()
            }
        }
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if ((contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (collisionAlienCatergory | collisionMissileCatergory)) {
            
            ship.run(SKAction.playSoundFileNamed("BarrelExploding.wav", waitForCompletion: false))
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            alienAttackRate += 0.05
            score = score + 1
            scoreLabel.text = "Score: \(score)"
        }
        
        if ((contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (collisionAlienCatergory | collisionSpaceShipCatergory)) {
            
            let mainMenuScene = MainMenuScene(size: self.size)
            self.view!.presentScene(mainMenuScene)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var touchedNode = self.atPoint(location)
        
        if let touchedNodeName = touchedNode.name {
            if touchedNodeName == "left button" {
                leftButtonPressed = true
            }
            else if touchedNodeName == "right button" {
                rightButtonPressed = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var touchedNode = self.atPoint(location)
        
        if let touchedNodeName = touchedNode.name {
            if touchedNodeName == "left button" {
                leftButtonPressed = false
            }
            else if touchedNodeName == "right button" {
                rightButtonPressed = false
            }
            else if touchedNodeName == "fire button" {
                
                let aMissile = SKSpriteNode(imageNamed: "missile.png")
                aMissile.position = CGPoint(x: ship.position.x, y: 100)
                aMissile.name = "missile"
                aMissile.physicsBody?.isDynamic = true
                aMissile.physicsBody = SKPhysicsBody(texture: aMissile.texture!, size: aMissile.size)
                aMissile.physicsBody?.affectedByGravity = false
                aMissile.physicsBody?.usesPreciseCollisionDetection = true
                aMissile.physicsBody?.categoryBitMask = collisionMissileCatergory
                aMissile.physicsBody?.contactTestBitMask = collisionAlienCatergory
                aMissile.physicsBody?.collisionBitMask = 0x0
                self.addChild(aMissile)
                let fireMissile = SKAction.moveTo(y: frame.size.height + 100, duration: 2)
                aMissile.run(fireMissile)
                missiles.append(aMissile)
                aMissile.run(SKAction.playSoundFileNamed("laser1.wav", waitForCompletion: false))
            }
        }
    }
}

// this will be commented out when code moved to Xcode

// set the frame to be the size for your iPad
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

let scene = SplashScene(size: frame.size)
scene.scaleMode = SKSceneScaleMode.resizeFill

let skView = SKView(frame: frame)
skView.showsFPS = true
skView.showsNodeCount = true
skView.presentScene(scene)

PlaygroundPage.current.liveView = skView
