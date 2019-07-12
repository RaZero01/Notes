//
//  TestMenuVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 29/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit
import SideMenu

class TestMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the menus
//        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: TestMenuVC)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
         let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "RootNC") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
//        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: TestMenuVC)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
         let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RootNC") as! UISideMenuNavigationController
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        // (Optional) Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false

    }
    
    @IBAction func menuBtn(_ sender: Any) {
        
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
