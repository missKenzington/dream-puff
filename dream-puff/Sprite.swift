//
//  Sprite.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 4/28/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import Foundation
import UIKit
import GLKit

// view objects
class Sprite {
    
    // --------------------------- static --------------------------- //
    static private var _program: GLuint = 0
    static private let _quad: [Float] =
    [
        -0.5, -0.5, // bottom left
        0.5, -0.5, // top right
        -0.5, 0.5, // top left
        0.5, 0.5 // top right
    ]
    
    static private let _quadTextureCoordinates: [Float] =
    [
        0.0, 0.25, // top right
        0.33, 0.25, // bottom right
        0.0, 0.0, // top left
        0.33, 0.0 // bottom left
    ]
    
    private static func setup() {
        let vertextShaderSource: NSString = """
        attribute vec2 position;
        attribute vec2 textureCoordinate;
        uniform vec2 translate;
        uniform vec2 scale;
        uniform vec2 translateTextureCoordinate;
        uniform vec2 scaleTextureCoordinate;
        varying vec2 textureCoordinateInterpolated;

        void main()
        {
            gl_Position = vec4(position.x * scale.x + translate.x, position.y * scale.y + translate.y, 0.0, 1.0);
            textureCoordinateInterpolated = vec2(textureCoordinate.x + translateTextureCoordinate.x, textureCoordinate.y + translateTextureCoordinate.y);
        }
        """
        
        let fragmentShaderSource: NSString = """
        uniform sampler2D textureUnit;
        varying highp vec2 textureCoordinateInterpolated;

        void main()
        {
            gl_FragColor = texture2D(textureUnit, textureCoordinateInterpolated);
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
        glBindAttribLocation(_program, 1, "textureCoordinate")

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
        
        // Redifine OpenGL defaults
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        glUseProgram(_program)
        glEnableVertexAttribArray(0)
        // param2 -> 2 - dimentions
        // stride -> how many bytes to skip (0 is tightly packed = size 2 * int = 8)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _quad)
        glEnableVertexAttribArray(1)
        glVertexAttribPointer(1 , 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _quadTextureCoordinates)
        
        
    }
    
    
    
    // --------------------------- members --------------------------- //
    var position: Vector = Vector()
    var texturePosition: Vector = Vector()
    var textureScale: Vector = Vector()
    var width: Float = 1.0
    var height: Float = 1.0
    var texture: GLuint = 0
    var isEnemy: Bool = false

    
    func draw() {
        if Sprite._program == 0 {
            Sprite.setup()
        }
        glUniform2f(glGetUniformLocation(Sprite._program, "translate"), position.x, position.y)
        glUniform2f(glGetUniformLocation(Sprite._program, "translateTextureCoordinate"), texturePosition.x, texturePosition.y)
        glUniform2f(glGetUniformLocation(Sprite._program, "scaleTextureCoordinate"), 1.0, 1.0)
        glUniform1i(glGetUniformLocation(Sprite._program, "textureUnit"), 0)
        glUniform2f(glGetUniformLocation(Sprite._program, "scale"), width, height)
        glBindTexture(GLenum(GL_TEXTURE_2D), texture)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}
