//
//  GameView.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 4/28/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import GLKit

class GameView: GLKViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to make the glkView functional
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
        glkView.drawableColorFormat = .RGBA8888
        EAGLContext.setCurrent(glkView.context)
        
        setup()
    }
    
    private func setup() {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        
        let vertextShaderSource: NSString = "" +
        "void main() \n" +
        "{ \n" +
        "   gl_Position = vec4(1.0, 1.0, 1.0, 1.0); \n" +
        "} \n" +
        "\n"
        
        
        // create and compile a vertex shader
        let vertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        var vertexShaderSourceUTF8 = vertextShaderSource.utf8String
        glShaderSource(vertexShader, 1, &vertexShaderSourceUTF8, nil)
        glCompileShader(vertexShader)
        let vetexShaderCompileStatus: GLuint = GL_FALSE
        
        
        // create a compile a fragmetn shader
        
        // link shaders into program
        
    }
    
    // if defined it will call, run before the display, update game model
    func update() {
        
    }
    
    // display
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(bitPattern: GL_COLOR_BUFFER_BIT))
        
        // draw a tringle
    }
}
