//
//  GameView.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 4/28/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import GLKit

class GameView: GLKViewController, GLKViewControllerDelegate{
    
    private let _playerSprite: Sprite = Sprite()
    private let _enemySprite: Sprite = Sprite()
    private var _enemiesLevelOne: [Sprite] = []
    private var _enemiesLevelTwo: [Sprite] = []
    private var _titleSprite: Sprite = Sprite()
    
    private var _isLevelOne:Bool = true
    private var _isLevelTwo:Bool = false
    private var _isLevelThree:Bool = false
    private var _finishLevel = false
    
    private let _backgroundSprite: Sprite = Sprite()
    
    private let _upArrowSprite: Sprite = Sprite()
    private let _downArrowSprite: Sprite = Sprite()
    private let _leftArrowSprite: Sprite = Sprite()
    private let _rightArrowSprite: Sprite = Sprite()
    
    private var _unicornTexture:  GLKTextureInfo? = nil
    private var _whiteCatTexture: GLKTextureInfo? = nil
    private var _blackCatTexture: GLKTextureInfo? = nil
    private var _brownCatTexture: GLKTextureInfo? = nil
    private var _orangeCatTexture: GLKTextureInfo? = nil
    private var _batTexture: GLKTextureInfo? = nil
    
    private var _backgroundTextureLevelOne: GLKTextureInfo? = nil
    private var _backgroundTextureLevelTwo: GLKTextureInfo? = nil
    private var _backgroundTextureLevelThree: GLKTextureInfo? = nil
    private var _levelOneTexture: GLKTextureInfo? = nil
    private var _levelTwoTexture: GLKTextureInfo? = nil
    private var _levelThreeTexture: GLKTextureInfo? = nil
    
    private var _upArrowTexture: GLKTextureInfo? = nil
    private var _downArrowTexture: GLKTextureInfo? = nil
    private var _leftArrowTexture: GLKTextureInfo? = nil
    private var _rightArrowTexture: GLKTextureInfo? = nil
    
    private var _lastUpdate: NSDate = NSDate()
    private var _gameTime = 0.0
    private var _animationSwitch = 0.0
    private var _displayTitleTime = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // to make the glkView functional
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
        glkView.drawableColorFormat = .RGBA8888
        EAGLContext.setCurrent(glkView.context)
        
        setup()
    }
    
    private func setup() {
        glClearColor(1.0, 1.0, 1.0, 1.0)
        _levelOneTexture = try! GLKTextureLoader.texture(with: UIImage(named: "LevelOneTitle")!.cgImage!, options: nil)
        _levelTwoTexture = try! GLKTextureLoader.texture(with: UIImage(named: "LevelTwoTitle")!.cgImage!, options: nil)
        _levelThreeTexture = try! GLKTextureLoader.texture(with: UIImage(named: "LevelThreeTitle")!.cgImage!, options: nil)
        _titleSprite.texture = _levelOneTexture!.name
        _titleSprite.width = 0.75
        _titleSprite.height = 0.5
        _titleSprite.textureScale.x = 1.0
        _titleSprite.textureScale.y = 1.0
        
        _backgroundTextureLevelOne = try! GLKTextureLoader.texture(with: UIImage(named: "sky.jpg")!.cgImage!, options: nil)
        _backgroundTextureLevelTwo = try! GLKTextureLoader.texture(with: UIImage(named: "dark-sky.jpg")!.cgImage!, options: nil)
        _backgroundTextureLevelThree = try! GLKTextureLoader.texture(with: UIImage(named: "underwater-level.png")!.cgImage!, options: nil)
        _backgroundSprite.texture = _backgroundTextureLevelOne!.name
        _backgroundSprite.width = 2.0
        _backgroundSprite.height = 2.0
        _backgroundSprite.textureScale.x = 1.0
        _backgroundSprite.textureScale.y = 1.0
        
        _upArrowTexture = try! GLKTextureLoader.texture(with: UIImage(named: "up-arrow")!.cgImage!, options: nil)
        _upArrowSprite.texture = _upArrowTexture!.name
        _upArrowSprite.width = 0.25
        _upArrowSprite.height = 0.25
        _upArrowSprite.position.x = 0.5
        _upArrowSprite.position.y = -0.65
        _upArrowSprite.textureScale.x = 1.0
        _upArrowSprite.textureScale.y = 1.0
        
        _downArrowTexture = try! GLKTextureLoader.texture(with: UIImage(named: "down-arrow")!.cgImage!, options: nil)
        _downArrowSprite.texture = _downArrowTexture!.name
        _downArrowSprite.width = 0.25
        _downArrowSprite.height = 0.25
        _downArrowSprite.position.x = -0.5
        _downArrowSprite.position.y = -0.65
        _downArrowSprite.textureScale.x = 1.0
        _downArrowSprite.textureScale.y = 1.0
        
        _leftArrowTexture = try! GLKTextureLoader.texture(with: UIImage(named: "left-arrow")!.cgImage!, options: nil)
        _leftArrowSprite.texture = _leftArrowTexture!.name
        _leftArrowSprite.width = 0.25
        _leftArrowSprite.height = 0.25
        _leftArrowSprite.position.x = -0.5
        _leftArrowSprite.position.y = -0.85
        _leftArrowSprite.textureScale.x = 1.0
        _leftArrowSprite.textureScale.y = 1.0
        
        _rightArrowTexture = try! GLKTextureLoader.texture(with: UIImage(named: "right-arrow")!.cgImage!, options: nil)
        _rightArrowSprite.texture = _rightArrowTexture!.name
        _rightArrowSprite.width = 0.25
        _rightArrowSprite.height = 0.25
        _rightArrowSprite.position.x = 0.5
        _rightArrowSprite.position.y = -0.85
        _rightArrowSprite.textureScale.x = 1.0
        _rightArrowSprite.textureScale.y = 1.0
        
        // setup sprite with a texture
        _unicornTexture = try! GLKTextureLoader.texture(with: UIImage(named: "unicorn")!.cgImage!, options: nil)
        _playerSprite.texture = _unicornTexture!.name
        _playerSprite.height = 0.20
        _playerSprite.width = 0.20
        _playerSprite.position.x = 0.0
        _playerSprite.position.y = -0.3
        _playerSprite.textureScale.x = 0.33
        _playerSprite.textureScale.y = 0.25
        
//        _whiteCatTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_white")!.cgImage!, options: nil)
        _blackCatTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_black")!.cgImage!, options: nil)
        _orangeCatTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_orange")!.cgImage!, options: nil)
        _brownCatTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_brown")!.cgImage!, options: nil)
        _batTexture = try! GLKTextureLoader.texture(with: UIImage(named: "fly-bat")!.cgImage!, options: nil)
        
        var dropTime = 3.0
        
        for index in 0...9 {
            let sprite = Sprite()
            
            if (index < 3) {
                sprite.texture = _blackCatTexture!.name
            } else if (index < 6) {
                sprite.texture = _orangeCatTexture!.name
            } else {
                sprite.texture = _brownCatTexture!.name
            }
            sprite.width = 0.25
            sprite.height = 0.25
            sprite.position.x = Random.random(min: -0.5, max: 0.5)
            sprite.position.y = 1.2
            sprite.texturePosition.y = 0.5
            sprite.textureScale.x = 0.33
            sprite.textureScale.y = 0.25
            sprite.dropTime = dropTime
            dropTime += 2.0
            _enemiesLevelOne.append(sprite)
        }
        
        dropTime = 35.0
        
        for _ in 0...5 {
            let sprite = Sprite()
            sprite.texture = _batTexture!.name
            sprite.width = 0.25
            sprite.height = 0.25
            sprite.position.x = -0.70
            sprite.position.y = Random.random(min: -1.0, max: 1.0)
            sprite.texturePosition.y = 0.0
            sprite.textureScale.x = 0.33
            sprite.textureScale.y = 0.5
            sprite.dropTime = dropTime
            dropTime += 1.0
            _enemiesLevelTwo.append(sprite)
        }
        
        _animationSwitch = 1.0
    }
    
    // if defined it will call, run before the display, update game model, game loop! ran once per frame
    func update() {
        let now = NSDate()
        let elapsed = now.timeIntervalSince(_lastUpdate as Date)
        _lastUpdate = now
        
        _gameTime += elapsed
        
        animateSprites()

        if (_isLevelOne == true){
            var clearedEnemies = 0
            for enemy in _enemiesLevelOne {
                if (enemy.dropTime > _gameTime) {
                    continue
                }
                if (_finishLevel == false) {
                    enemy.position.y -= 0.01

                    if (enemy.position.y < -1.0){
                        enemy.position.x = Random.random(min: -0.5, max: 0.5)
                        enemy.position.y = 1.2
                    }
                    if (_gameTime >  20.0) {
                        _finishLevel = true
                    }
                } else {
                    enemy.position.y -= 0.01
                   
                    if (enemy.position.y < -1.0) {
                        clearedEnemies += 1
                        if (clearedEnemies == 10) {
                            _isLevelOne = false
                            _isLevelTwo = true
                            _backgroundSprite.texture = _backgroundTextureLevelTwo!.name
                            _titleSprite.texture = _levelTwoTexture!.name
                            _displayTitleTime = 5.0
                            _finishLevel = false
                        }
                    }
                }
            }
        } else if (_isLevelTwo == true) {
            var clearedEnemies = 0
            for enemy in _enemiesLevelTwo {
                if (enemy.dropTime > _gameTime) {
                    continue
                }
                if (_finishLevel == false) {
                    enemy.position.x += 0.01
                    
                    if (enemy.position.x > 0.7){
                        enemy.position.x = -0.6
                        enemy.position.y = Random.random(min: -1.0, max: 1.0)
                    }
                    if (_gameTime >  60.0) {
                        _finishLevel = true
                    }
                } else {
                    enemy.position.x += 0.01
                    
                    if (enemy.position.x > 0.7) {
                        clearedEnemies += 1
                        if (clearedEnemies == 6) {
                            _isLevelTwo = false
                            _isLevelThree = true
                            _backgroundSprite.texture = _backgroundTextureLevelThree!.name
                            _titleSprite.texture = _levelThreeTexture!.name
                            _displayTitleTime = 5.0
                            _finishLevel = false
                        }
                    }
                }
            }
        } else if (_isLevelThree == true) {
            var clearedEnemies = 0
            print("level 3")
//            for enemy in _enemiesLevelTwo {
//                if (enemy.dropTime > _gameTime) {
//                    continue
//                }
//                if (_finishLevel == false) {
//                    enemy.position.y -= 0.01
//
//                    if (enemy.position.y < -1.0){
//                        enemy.position.x = Random.random(min: -0.5, max: 0.5)
//                        enemy.position.y = 1.2
//                    }
//                    if (_gameTime >  50.0) {
//                        _finishLevel = true
//                    }
//                } else {
//                    enemy.position.y -= 0.01
//
//                    if (enemy.position.y < -1.0) {
//                        clearedEnemies += 1
//                    }
//                    if (clearedEnemies == 10) {
//                        _isLevelOne = false
//                        _isLevelTwo = true
//                        _backgroundSprite.texture = _backgroundTextureLevelTwo!.name
//                        _titleSprite.texture = _levelTwoTexture!.name
//                    }
//                }
//            }
        }
        
        
//        _enemySprite.position.x = Float(cos(_animation))
//        _enemySprite.position.y = Float(sin(_animation))
//        _sprite.position.y += 0.005
        
    }
    
    func animateSprites() {
        if (_gameTime >= _animationSwitch) {
            
            if (_playerSprite.texturePosition.x == 0) {
                _playerSprite.texturePosition.x = 0.33
            } else if (_playerSprite.texturePosition.x == 0.33) {
                _playerSprite.texturePosition.x = 0.66
            } else {
                _playerSprite.texturePosition.x = 0.0
            }
            
            _animationSwitch = _gameTime + 0.33

            if (_isLevelOne) {
                for enemy in _enemiesLevelOne {
                    if (enemy.texturePosition.x == 0) {
                        enemy.texturePosition.x = 0.33
                    } else if (enemy.texturePosition.x == 0.33) {
                        enemy.texturePosition.x = 0.66
                    } else {
                        enemy.texturePosition.x = 0.0
                    }
                }
            } else if (_isLevelTwo) {
                for enemy in _enemiesLevelTwo {
                    if (enemy.texturePosition.x == 0) {
                        enemy.texturePosition.x = 0.33
                    } else if (enemy.texturePosition.x == 0.33) {
                        enemy.texturePosition.x = 0.66
                    } else {
                        enemy.texturePosition.x = 0.0
                        if(enemy.texturePosition.y == 0.5) {
                            enemy.texturePosition.y = 0.0
                        } else {
                            enemy.texturePosition.y = 0.5
                        }
                    }
                }
            }
        }
    }
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        update()
    }
    
    // update display
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(bitPattern: GL_COLOR_BUFFER_BIT))
        
        let height = GLsizei(view.bounds.height * view.contentScaleFactor)
        let offset = GLsizei((view.bounds.height - view.bounds.width) * -0.5 * view.contentScaleFactor)
        glViewport(offset, 0 ,height, height)
        _backgroundSprite.draw()

        if ((_displayTitleTime > 0.0)) {
            _displayTitleTime -= 0.1
            _titleSprite.draw()
        } else if (_isLevelOne == true) {
            _upArrowSprite.draw()
            _downArrowSprite.draw()
            _leftArrowSprite.draw()
            _rightArrowSprite.draw()
            _playerSprite.draw()
            
            for enemy in _enemiesLevelOne {
                enemy.draw()
            }
        } else if (_isLevelTwo == true) {
            _upArrowSprite.draw()
            _downArrowSprite.draw()
            _leftArrowSprite.draw()
            _rightArrowSprite.draw()
            _playerSprite.draw()
            
            for enemy in _enemiesLevelTwo {
                enemy.draw()
            }
        } else if (_isLevelThree == true) {
            _upArrowSprite.draw()
            _downArrowSprite.draw()
            _leftArrowSprite.draw()
            _rightArrowSprite.draw()
            _playerSprite.draw()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
        let point = touch.location(in: self.view)
        var glkX: Float = 0.0
        var glkY: Float = 0.0
        
        if (point.x > self.view.center.x){
            glkX = Float((point.x - self.view.center.x)/(self.view.bounds.maxX - self.view.center.x))
        } else {
            glkX = 1.0 - Float((point.x)/(self.view.center.x))
            glkX *= -1
        }
        glkX *= 0.5
        
        if (point.y < self.view.center.y){
            glkY = 1.0 - Float((point.y)/(self.view.center.y))
        } else {
            glkY = Float((point.y - self.view.center.x)/(self.view.bounds.maxY - self.view.center.y))
            glkY = 1.0 - Float((point.y)/(self.view.center.y))
        }
        var absX = abs(glkX - _rightArrowSprite.position.x)
        var absY = abs(glkY - _rightArrowSprite.position.y)
        var xSquared = absX * absX
        var ySquared = absY * absY
        var radius = (_rightArrowSprite.width * 0.5) * (_rightArrowSprite.width * 0.5)
        if ((xSquared + ySquared < radius) && glkX >= 0.0) {
            _playerSprite.position.x += 0.05
            _playerSprite.texturePosition.y = 0.25
        }
        
        absX = abs(glkX - _leftArrowSprite.position.x)
        absY = abs(glkY - _leftArrowSprite.position.y)
        xSquared = absX * absX
        ySquared = absY * absY
        radius = (_leftArrowSprite.width * 0.5) * (_leftArrowSprite.width * 0.5)
        
        if ((xSquared + ySquared < radius) && glkX < 0.0) {
            _playerSprite.position.x -= 0.05
            _playerSprite.texturePosition.y = 0.75
        }
        
        absX = abs(glkX - _upArrowSprite.position.x)
        absY = abs(glkY - _upArrowSprite.position.y)
        xSquared = absX * absX
        ySquared = absY * absY
        radius = (_upArrowSprite.width * 0.5) * (_upArrowSprite.width * 0.5)
        
        if ((xSquared + ySquared < radius)) {
            _playerSprite.position.y += 0.05
            _playerSprite.texturePosition.y = 0.0
        }
        
        absX = abs(glkX - _downArrowSprite.position.x)
        absY = abs(glkY - _downArrowSprite.position.y)
        xSquared = absX * absX
        ySquared = absY * absY
        radius = (_downArrowSprite.width * 0.5) * (_downArrowSprite.width * 0.5)
        
        if ((xSquared + ySquared < radius)) {
            _playerSprite.position.y -= 0.05
            _playerSprite.texturePosition.y = 0.5
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}

public class Random {
    
    /// Randomly returns either 1.0 or -1.0.
    public static var randomSign: Float {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Float {
        return Float(drand48())
    }
    
    /// Random CGFloat between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random CGFloat point number between 0 and n max
    public static func random(min: Float, max: Float) -> Float {
        return Random.random * (max - min) + min
    }
}
