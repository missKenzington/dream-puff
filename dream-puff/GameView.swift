//
//  GameView.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 4/28/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import GLKit

class GameView: GLKViewController {
    
    // 0 can be an error state
    private var _program: GLuint = 0
    
    // cpu side
    private var _translateX: Float = 0.0
    private var _translateY: Float = 0.0
    private var _scaleX: Float = 0.5
    private var _scaleY: Float = 0.3
    
    private let _quad: [Float] =
    [
        -0.5, -0.5,
        0.5, -0.5,
        -0.5, 0.5,
        0.5, 0.5
    ]
    
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
        glClearColor(0.737254902, 0.9843137255, 1.0, 1.0);
        
        
        let vertextShaderSource: NSString = """
        attribute vec2 position;
        uniform vec2 translate;
        uniform vec2 scale;
        void main()
        {
            gl_Position = vec4(position.x * scale.x + translate.x, position.y * scale.y + translate.y, 0.0, 1.0);
        }
        """
        
        let fragmentShaderSource: NSString = """
        uniform highp vec4 color;
        void main()
        {
            gl_FragColor = color;
        }
        """
        
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
        _program = glCreateProgram()
        glAttachShader(_program, vertexShader)
        glAttachShader(_program, fragmentShader)
        glBindAttribLocation(_program, 0, "position")
        glLinkProgram(_program)
        var programLinkStatus: GLint = GL_FALSE
        glGetProgramiv(_program, GLenum(GL_LINK_STATUS), &programLinkStatus)
        if (programLinkStatus == GL_FALSE){
            var programLogLength: GLint = 0
            glGetProgramiv(_program, GLenum(GL_INFO_LOG_LENGTH), &programLogLength)
            let programLog = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(programLogLength))
            glGetProgramInfoLog(_program, programLogLength, nil, programLog)
            let programLogString: NSString = NSString(utf8String: programLog)!
            print("Program link failed! Error: \(programLogString)")
        }
        
        glUseProgram(_program)
        glEnableVertexAttribArray(0)
        
        
        // param2 -> 2 - dimentions
        // stride -> how many bytes to skip (0 is tightly packed = size 2 * int = 8)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _quad)
    }
    
    // if defined it will call, run before the display, update game model
    func update() {
        
    }
    
    // update display
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(bitPattern: GL_COLOR_BUFFER_BIT))
        
        _translateX += 0.001
        _translateY -= 0.005
        
        // draw a tringle
        
        // triagle 1
        glUniform2f(glGetUniformLocation(_program, "translate"), _translateX, _translateY)
        glUniform4f(glGetUniformLocation(_program, "color"), 1.0, 0.0, 0.0, 1.0)
        glUniform2f(glGetUniformLocation(_program, "scale"), _scaleX, _scaleY)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)

        // triagle 2
        glUniform2f(glGetUniformLocation(_program, "translate"), -_translateX, -_translateY)
        glUniform4f(glGetUniformLocation(_program, "color"), 0.0, 0.0, 1.0, 1.0)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
        
    }
}
