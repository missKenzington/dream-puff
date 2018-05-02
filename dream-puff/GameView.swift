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
    private var _catTexture:  GLKTextureInfo? = nil
    private var _enemyTexture: GLKTextureInfo? = nil
    private var _lastUpdate: NSDate = NSDate()
    private var _animation = 0.0
    
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
//
//
//        backgroundSprite1.texture = backgroundTexture1!.name
//        backgroundSprite1.width = 2.0
//        backgroundSprite1.height = 2.0
//        backgroundSprite1.positionX = 0.0
//        backgroundSprite1.positionY = 0.0
        
        glClearColor(0.737254902, 0.9843137255, 1.0, 1.0)
        
        // setup sprite with a texture
        _catTexture = try! GLKTextureLoader.texture(with: UIImage(named: "unicorn")!.cgImage!, options: nil)
        _playerSprite.texture = _catTexture!.name
        _playerSprite.height = 0.25
        _playerSprite.width = 0.25
        
        _enemyTexture = try! GLKTextureLoader.texture(with: UIImage(named: "cat_black")!.cgImage!, options: nil)
        _enemySprite.texture = _enemyTexture!.name
        _enemySprite.width = 0.25
        _enemySprite.height = 0.25
        _enemySprite.position.x = -0.5
        _enemySprite.position.y = 1.0
    }
    
    // if defined it will call, run before the display, update game model, game loop! ran once per frame
    func update() {
        let now = NSDate()
        let elapsed = now.timeIntervalSince(_lastUpdate as Date)
        _lastUpdate = now
        
        _animation += elapsed * 0.25
        
//        _sprite.position.x += Float(elapsed * 0.25)
        
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
        _playerSprite.draw()
        _enemySprite.draw()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
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
