//
//  GameIntroView.swift
//  puff-the-magic-unicorn
//
//  Created by Makenzie Elliott on 4/21/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import UIKit


protocol MainMenuDelegate: AnyObject {
    func newGame()
    func returnToGame()
    func displayHighScoreTable()
}


class MainMenuView: UIView {
    
    
    // --------------------------- members --------------------------- //
    weak var delegate: MainMenuDelegate? = nil
    
    var showResume = false
    
//    var panel: UIView = UIView()
    
    var whaleUnicornImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        let image = UIImage(named: "whale-unicorn.png")
        imageView.image = image;
        return imageView
    }()
    
    var dreamPuffLabel: UILabel  = {
        let label = UILabel()
        label.text = "Dream Puff"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont(name: "chalkduster", size: 27)
        label.backgroundColor = UIColor(white: 1, alpha: 0.0)
        label.textAlignment = .center
        return label
    }()
    var startGameBtn: UIButton = {
        let button = UIButton()
        button.setTitle("start game", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont(name: "chalkduster", size: 18)
        button.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 1.0, green: 0.737254902, blue: 0.8509803922, alpha: 1.0)
        return button
    }()
    //    self.navigationController?.pushViewController(gameViewController, animated: true)
    
    
    var resumeGameBtn: UIButton = {
        let button = UIButton()
        button.setTitle("resume game", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont(name: "chalkduster", size: 18)
        button.addTarget(self, action: #selector(returnToLastGame), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.737254902, green: 0.9843137255, blue: 1.0, alpha: 1.0)
        return button
    }()
    
    var highScoresBtn: UIButton = {
        let button = UIButton()
        button.setTitle("high scores", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont(name: "chalkduster", size: 18)
        button.addTarget(self, action: #selector(displayHighScore), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.9725490196, green: 1.0, blue: 0.5647058824, alpha: 1.0)
        return button
    }()
    
    
    // --------------------------- constructors --------------------------- //
    
    // --------------------------- UIView --------------------------- //
    override init(frame: CGRect) {
//        panel.backgroundColor = UIColor.white
        super.init(frame: frame)
        
        
//        addSubview(panel)
        addSubview(whaleUnicornImageView)
        addSubview(dreamPuffLabel)
        addSubview(startGameBtn)
        addSubview(resumeGameBtn)
        addSubview(highScoresBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var rect: CGRect = self.bounds
        var rowRect: CGRect
        
        (rowRect, rect) = rect.divided(atDistance: rect.maxY / 4.0, from: .minYEdge)
        (rowRect, rect) = rect.divided(atDistance: rect.maxY / 5.0, from: .minYEdge)
//        (panel.frame, rect) = rect.divided(atDistance: rect.maxY / 5.0, from: .minYEdge)
        whaleUnicornImageView.frame = CGRect(x: rowRect.minX, y: rowRect.minY, width: rowRect.height + 20, height: rowRect.height)
        dreamPuffLabel.frame = CGRect(x: rowRect.minX + rowRect.height - 20, y: rowRect.minY, width: rowRect.width - rowRect.height, height: rowRect.height)
        
        
        startGameBtn.frame = CGRect(x: rect.minX, y:  rect.minY + 30, width: rect.width, height: 60)
        
        if (showResume == true) {
            resumeGameBtn.frame = CGRect(x: rect.minX, y:  rect.minY + 90, width: rect.width, height: 60)
            highScoresBtn.frame = CGRect(x: rect.minX, y:  rect.minY + 150, width: rect.width, height: 60)
        } else {
            highScoresBtn.frame = CGRect(x: rect.minX, y:  rect.minY + 90, width: rect.width, height: 60)

        }
    }
    
    // --------------------------- Target Actions Methods --------------------------- //
    @objc func newGame(_ sender: UIButton) {
        delegate?.newGame()
    }
    
    @objc func returnToLastGame(_ sender: UIButton) {
        delegate?.returnToGame()
    }
    
    @objc func displayHighScore(_ sender: UIButton) {
        delegate?.displayHighScoreTable()
    }
    
}
