//
//  MainMenuViewController.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 4/21/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuDelegate, GameViewDelegate {
    
    var introView: MainMenuView {
        return view as! MainMenuView
    }
    
    var gameView: GameView = GameView()
    var canResumeGame = false
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        introView.showResume = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = MainMenuView()
        introView.backgroundColor = UIColor(patternImage: UIImage(named:"unicorn-sky.jpg")!)
    }
    
    
    override func viewDidLoad() {
        introView.delegate = self
        gameView.extraDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func newGame() {
        gameView.resetGame()
        self.navigationController?.pushViewController(gameView, animated: true)
    }
    
    func returnFromGame() {
        introView.showResume = true
        introView.setNeedsLayout()
        let controller = self.navigationController!.popViewController(animated: true)
        controller?.removeFromParentViewController()
        
    }
    
    func returnToGame() {
        self.navigationController?.pushViewController(gameView, animated: true)
    }
}
