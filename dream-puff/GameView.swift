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
        
        let vertextShaderSource: NSString = NSString(string: "void main() {\n" +
        "gl_Position = vec4(1.0, 1.0, 0.0, 1.0);\n" +
        "}\n")
        
        let fragmentShaderSource: NSString = NSString(string: "void main() {\n" +
            "gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);\n" +
            "}\n")
        
        
        // create and compile a vertex shader
        let vertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        var vertexShaderSourceUTF8 = vertextShaderSource.utf8String
        glShaderSource(vertexShader, 1, &vertexShaderSourceUTF8, nil)
        glCompileShader(vertexShader)
        var vetexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(vertexShader, GLenum(GL_COMPILE_STATUS), &vetexShaderCompileStatus)
        
        if (vetexShaderCompileStatus == GL_FALSE) {
            // print error, shader cannot be cteaded
            var vertexShaderLogLength: GLint = 0
            glGetShaderiv(vertexShader, GLenum(GL_INFO_LOG_LENGTH), &vertexShaderLogLength)
            // allocate memory for the string
            let vertexShaderLog = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(vertexShaderLogLength)) // deallocated happens automagically
            glGetShaderInfoLog(vertexShader, vertexShaderLogLength, nil, vertexShaderLog)
            let vertexShaderLogString: NSString? = NSString(utf8String: vertexShaderLog)!
            print("Vertex shader compile failed! Error: \(String(describing: vertexShaderLogString))")
            // TODO - prevent drwaing if we dont have a vertex shader
        }
    
        
        // create a compile a fragmetn shader
        let fragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        var fragmentShaderSourceUTF8 = fragmentShaderSource.utf8String
        glShaderSource(fragmentShader, 1, &fragmentShaderSourceUTF8, nil)
        glCompileShader(fragmentShader)
        var fragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(fragmentShader, GLenum(GL_COMPILE_STATUS), &fragmentShaderCompileStatus)
        
        if (fragmentShaderCompileStatus == GL_FALSE) {
            // print error, shader cannot be cteaded
            var fragmentShaderLogLength: GLint = 0
            glGetShaderiv(fragmentShader, GLenum(GL_INFO_LOG_LENGTH), &fragmentShaderLogLength)
            // allocate memory for the string
            let fragmentShaderLog = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(fragmentShaderLogLength)) // deallocated happens automagically
            glGetShaderInfoLog(fragmentShader, fragmentShaderLogLength, nil, fragmentShaderLog)
            let fragmentShaderLogString: NSString? = NSString(utf8String: fragmentShaderLog)!
            print("Fragment shader compile failed! Error: \(String(describing: fragmentShaderLogString))")
            // TODO - prevent drwaing if we dont have a fragment shader
        }
        
        // link shaders into program
        let program: GLuint = glCreateProgram()
        glAttachShader(program, vertexShader)
        glAttachShader(program, fragmentShader)
        glLinkProgram(program)
        var programLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &programLinkStatus)
        if (programLinkStatus == GL_FALSE){
            var programLogLength: GLint = 0
            glGetProgramiv(program, GLenum(GL_INFO_LOG_LENGTH), &programLogLength)
            let programLog = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(programLogLength))
            glGetProgramInfoLog(program, programLogLength, nil, programLog)
            let programLogString: NSString = NSString(utf8String: programLog)!
            print("Program link failed! Error: \(programLogString)")
        }
        
        glUseProgram(program)
        
    }
    
    // if defined it will call, run before the display, update game model
    func update() {
        
    }
    
    // update display
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(bitPattern: GL_COLOR_BUFFER_BIT))
        
        // draw a tringle
    }
}
