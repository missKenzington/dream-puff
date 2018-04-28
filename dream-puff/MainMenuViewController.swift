//
//  MainMenuViewController.swift
//  puff-the-magic-unicorn
//
//  Created by Makenzie Elliott on 4/21/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuDelegate {
    var introView: MainMenuView {
        return view as! MainMenuView
    }
    
    override func loadView() {
        self.view = MainMenuView()
        introView.backgroundColor = UIColor(patternImage: UIImage(named:"unicorn-sky.jpg")!)
    }
    
    
    override func viewDidLoad() {
        introView.delegate = self
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
        print("NEW GAME")
        self.navigationController?.pushViewController(GameView(), animated: true)
    }
}
