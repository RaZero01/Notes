//
//  AuthVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 05/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AuthVC: UIViewController {
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var email: String = ""
    var password: String = ""
    
    @IBOutlet weak var register: UIButton!
    
    
    
    var refUser = DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back2")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        register.layer.cornerRadius = register.frame.height / 2
        register.clipsToBounds = true
        
        refUser = Database.database().reference().child("notes")

    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        
      addUser()
        
//        signUpAlert(title: "Успешно!", message: "Вы успешно зарегистрировались!")
      
    }
    
    func signUpAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ГОТОВО", style: .default, handler: {(action) in
//            alert.dismiss(animated: true, completion: nil)
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = Storyboard.instantiateViewController(withIdentifier: "MainVC")
            self.present(vc, animated: false)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func addUser(){
        
        
        let ref = Database.database().reference()
        
        guard let email = emailTextField.text else {
            return
            
        }
        guard let password = passwordTextField.text else {
            return
        }
        guard let username = usernameTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){
            User, error in
            if  error == nil && User != nil {
                self.signUpAlert(title: "Успешно!", message: "Вы успешно зарегистрировались!")
            } else {
                self.signUpAlert(title: "Ошибка!", message: error!.localizedDescription)
            }
            
            
        }
        
        let emailID = email.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        _ = refUser.childByAutoId().key as! String

        let newUser = ["username":username, "email":email, "password":password, "Notes": ""]
        
        refUser.child("\(emailID)").setValue(newUser)
//        refUser.child("\(emailID)").child("Notes")
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
