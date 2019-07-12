//
//  SideMenuVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 29/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import Foundation
import SideMenu

class SideMenuVC: UITableViewController {
    
    var rows = ["Зарегистрироваться", "Войти"]
    var segueIdentifiers = ["AuthVC", "LoginVC"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
        let imageView = UIImageView(image: UIImage(named: "back2"))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.backgroundView = imageView
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "back2")!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        cell.textLabel!.text = "\(rows[indexPath.row])"
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)
        
        let VC = Storyboard.instantiateViewController(withIdentifier: segueIdentifiers[indexPath.row])
        
        self.present(VC, animated: true)
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}
