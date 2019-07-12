//
//  CurrentNoteVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 22/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import AVKit

class CurrentNoteVC: UIViewController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var ref: DatabaseReference!
    
    var getNoteName = String()
    var getNoteText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CurrentNoteVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        

        
        noteTextField.keyboardDismissMode = .onDrag
        
        noteTextField.inputAccessoryView = toolBar
        noteTextField.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        noteTextField.font = UIFont.systemFont(ofSize: 20)
        noteTextField.textColor = UIColor.black
        noteTextField.font = UIFont.boldSystemFont(ofSize: 20)
        noteTextField.font = UIFont(name: "Noteworthy", size: 23)
        noteTextField.isEditable = true
        noteTextField.dataDetectorTypes = UIDataDetectorTypes.link
        noteTextField.layer.cornerRadius = 10
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back2")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)

        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        let notesRef = Database.database().reference().child("notes").child("\(emailID as! String)").child("Notes")
        
        notesRef.observe(.value) {
            snapshot in
            
            var numberOfNotes = snapshot.childrenCount
            
        }
        
        noteTextField.text = getNoteText
        
        
        notesRef.observe(.value, with: { (snapshot: DataSnapshot!) in
            var numberOfNotes = snapshot.childrenCount
            
            
            if var testList = snapshot.value as? [String: AnyObject]{
                let arrayOfNames: [String] = Array(testList.keys)
                let arrayOfNotes = Array(testList.values)
               
                var notesArray: [String: String] = [:]
                
                for (index, element) in arrayOfNames.enumerated(){
                    notesArray[element] = arrayOfNotes[index] as! String
                }
                
                
            }
            
        })
        
        let changedNote = ref.child("notes").child("\(emailID as! String)").child("Notes").child("\(getNoteName)")
        navBar.title = changedNote.key as! String
        
        
    }
    
    func savedAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ГОТОВО", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        let notesRef = Database.database().reference().child("notes").child("\(emailID as! String)").child("Notes")
        
        let changedNote = ref.child("notes").child("\(emailID as! String)").child("Notes").child("\(getNoteName)")
        
        changedNote.setValue("\(noteTextField.text as String)")
        
        savedAlert(title: "Успешно!", message: "Заметка сохранена!")
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    

    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrameRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        let keyboardRect = keyboardFrameRect.cgRectValue
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
        noteTextField.contentInset = contentInset
        noteTextField.scrollIndicatorInsets = contentInset
    }


}
