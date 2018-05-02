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
    
    private let _backgroundSprite: Sprite = Sprite()
    
    private let _upArrowSprite: Sprite = Sprite()
    private let _downArrowSprite: Sprite = Sprite()
    private let _leftArrowSprite: Sprite = Sprite()
    private let _rightArrowSprite: Sprite = Sprite()
    
    private var _catTexture:  GLKTextureInfo? = nil
    private var _enemyTexture: GLKTextureInfo? = nil
    
    private var _backgroundTexture: GLKTextureInfo? = nil
    
    private var _upArrowTexture: GLKTextureInfo? = nil
    private var _downArrowTexture: GLKTextureInfo? = nil
    private var _leftArrowTexture: GLKTextureInfo? = nil
    private var _rightArrowTexture: GLKTextureInfo? = nil
    
    private var _lastUpdate: NSDate = NSDate()
    private var _animation = 0.0
    private var _animationSwitch = 0.0
    
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
        glClearColor(0.737254902, 0.9843137255, 1.0, 1.0)
        
        _backgroundTexture = try! GLKTextureLoader.texture(with: UIImage(named: "background1.jpg")!.cgImage!, options: nil)
        _backgroundSprite.texture = _backgroundTexture!.name
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
        _catTexture = try! GLKTextureLoader.texture(with: UIImage(named: "unicorn")!.cgImage!, options: nil)
        _playerSprite.texture = _catTexture!.name
        _playerSprite.height = 0.20
        _playerSprite.width = 0.20
        _playerSprite.position.x = 0.0
        _playerSprite.position.y = -0.7
        _playerSprite.textureScale.x = 0.33
        _playerSprite.textureScale.y = 0.25
        
        _enemyTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_white")!.cgImage!, options: nil)
        _enemySprite.texture = _enemyTexture!.name
        _enemySprite.width = 0.25
        _enemySprite.height = 0.25
        _enemySprite.position.x = -0.4
        _enemySprite.position.y = 1.0
        _enemySprite.texturePosition.y = 0.5
        _enemySprite.textureScale.x = 0.33
        _enemySprite.textureScale.y = 0.25
        
        _animationSwitch = 1.0
    }
    
    // if defined it will call, run before the display, update game model, game loop! ran once per frame
    func update() {
        let now = NSDate()
        let elapsed = now.timeIntervalSince(_lastUpdate as Date)
        _lastUpdate = now
        
        _animation += elapsed
        
        if (_animation >= _animationSwitch) {
            _animationSwitch = _animation + 0.33

            if (_enemySprite.texturePosition.x == 0) {
                _enemySprite.texturePosition.x = 0.33
            } else if (_enemySprite.texturePosition.x == 0.33) {
                _enemySprite.texturePosition.x = 0.66
            } else {
                _enemySprite.texturePosition.x = 0.0
            }
            
            if (_playerSprite.texturePosition.x == 0) {
                _playerSprite.texturePosition.x = 0.33
            } else if (_playerSprite.texturePosition.x == 0.33) {
                _playerSprite.texturePosition.x = 0.66
            } else {
                _playerSprite.texturePosition.x = 0.0
            }
            
        }
        
//        _enemySprite.texturePosition.y += 0.25
//        _enemySprite.texturePosition.y += 0.001
//        _playerSprite.position.x += 0.001
        
//        _enemySprite.position.x = Float(cos(_animation))
//        _enemySprite.position.y = Float(sin(_animation))
//        _sprite.position.y += 0.005
        
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
        _upArrowSprite.draw()
        _downArrowSprite.draw()
        _leftArrowSprite.draw()
        _rightArrowSprite.draw()
        
        
        _playerSprite.draw()
        _enemySprite.draw()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
        // 200, 400 is the center of the screen
        print(self.view.bounds.height)
        print("x")
        print(self.view.bounds.width)
        print(touch)
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
