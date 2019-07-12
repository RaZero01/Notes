//
//  LoginVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 06/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back2")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
       
        loginBtn.layer.cornerRadius = loginBtn.frame.height / 2
        loginBtn.clipsToBounds = true
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
            
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            User, error in
            if error == nil && User != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                
                self.logInAlert(title: "Ошибка!", message: error!.localizedDescription)
            }
        }
        
        
        
    }
    
    func logInAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ГОТОВО", style: .default, handler: {(action) in
                        alert.dismiss(animated: true, completion: nil)
           
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    

}
