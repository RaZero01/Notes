//
//  ViewController.swift
//  Notes
//
//  Created by Konstantin Razinkov on 05/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var registerBtn: CustomButton!
    @IBOutlet weak var accessBtn: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back2")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
//        registerBtn.layer.cornerRadius = registerBtn.frame.height / 2
//        registerBtn.clipsToBounds = true
//        
//        accessBtn.layer.cornerRadius = accessBtn.frame.height / 2
//        accessBtn.clipsToBounds = true
//
        
        
        
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toNotes", sender: self)
        }
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    

}

