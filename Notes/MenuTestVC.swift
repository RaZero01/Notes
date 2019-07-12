//
//  MenuTestVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 29/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit
import SideMenu

class MenuTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSideMenu()
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "SideMenuNC") as? UISideMenuNavigationController
//        SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
//        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
  

}
