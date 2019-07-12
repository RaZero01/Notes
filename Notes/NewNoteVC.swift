//
//  NewNoteVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 16/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewNoteVC: UIViewController {
//    @IBOutlet weak var saveNoteBtn: UIBarButtonItem!

    @IBOutlet weak var saveNoteBtn: UIButton!
    
    @IBOutlet weak var warningText: UITextView!
    @IBOutlet weak var noteName: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    
    var amountOfNotes: UIBarButtonItem!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        
        noteText.keyboardDismissMode = .onDrag
        
        noteText.inputAccessoryView = toolBar
        noteText.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        noteText.font = UIFont.systemFont(ofSize: 20)
        noteText.textColor = UIColor.black
        noteText.font = UIFont.boldSystemFont(ofSize: 20)
        noteText.font = UIFont(name: "Noteworthy", size: 23)
        noteText.isEditable = true
        noteText.dataDetectorTypes = UIDataDetectorTypes.link
        noteText.layer.cornerRadius = 10
        warningText.layer.cornerRadius = 10
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewNoteVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back2")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        _ = ref.child("notes").child("\(emailID as! String)").observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            let username = dataDict["username"]
        
    })
    }
    
     var test = 0
   
    
    func savedAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ГОТОВО", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func saveNoteBtn(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        let notesRef = Database.database().reference().child("notes").child("\(emailID as! String)").child("Notes")
        
        savedAlert(title: "Успешно!", message: "Заметка сохранена!")
        
        let text = noteText.text
        
        notesRef.observe(.value) {
            snapshot in
            
            var numberOfNotes = snapshot.childrenCount
        
        
            self.test = Int(numberOfNotes)
        
        }
        
        
        let newNote = ref.child("notes").child("\(emailID as! String)").child("Notes").child("\(noteName.text as! String)")
        newNote.setValue("\(noteText.text as String)")
        

        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequenceVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrameRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        let keyboardRect = keyboardFrameRect.cgRectValue
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height + 50, right: 0)
        noteText.contentInset = contentInset
        noteText.scrollIndicatorInsets = contentInset
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

}
