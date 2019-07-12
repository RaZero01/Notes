//
//  MenuVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 06/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MenuVC: UIViewController {
//    @IBOutlet weak var navBar: UINavigationItem!
    
    var ref: DatabaseReference!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setBackgroundColor(colorOne: Colors.brightOrange, colorTwo: Colors.red)
        
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        _ = ref.child("notes").child("\(emailID as! String)").observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            let username = dataDict["username"]
          
            
//            self.navBar.title = "WELCOME, \(username as! String)"
            
        })
        
        let txtTest = UITextField(frame: CGRect(x: 20.0, y: 300.0, width: 200.0 , height: 80.0))
        txtTest.backgroundColor = .white
        self.view.addSubview(txtTest)
        
    }
  
    
//    @IBAction func logOutBtn(_ sender: Any) {
//        try! Auth.auth().signOut()
//        self.dismiss(animated: false, completion: nil)
//    }
    

    
    override open var shouldAutorotate: Bool {
        return false
    }

}
