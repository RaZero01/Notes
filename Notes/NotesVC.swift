//
//  NotesVC.swift
//  Notes
//
//  Created by Konstantin Razinkov on 16/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NotesVC: UITableViewController {
    
    @IBOutlet weak var navBarNotes: UINavigationItem!
    
    var ref: DatabaseReference!
    
    var notes = [String]()
    var notesArray: [String: String] = [:]
    
    let cellId = "cellId"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "back2"))
        
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        var test = 0
        
        
     
        
//        tableView.setBackgroundColor(colorOne: Colors.brightOrange, colorTwo: Colors.red)
        
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        
        let emailID = user?.email!.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        _ = ref.child("notes").child("\(emailID as! String)").observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            let username = dataDict["username"]
            
            _ = self.ref.child("notes").child("\(emailID as! String)").child("Notes")
            
            self.navBarNotes.title = "\(username as! String)"
            
        })
        
        
        
        let notesRef = Database.database().reference().child("notes").child("\(emailID as! String)").child("Notes")
        
        notesRef.observe(.value) {
            snapshot in
            
            var numberOfNotes = snapshot.childrenCount
            
           test = Int(numberOfNotes)
        }
        print(test)
        
      
        notesRef.observe(.value, with: { (snapshot: DataSnapshot!) in
            var numberOfNotes = snapshot.childrenCount
            
//            print(numberOfNotes)
            test = Int(numberOfNotes)
            
           if var testList = snapshot.value as? [String: AnyObject]{
                let arrayOfNames: [String] = Array(testList.keys)
                let arrayOfNotes = Array(testList.values)
            
//            var notesArray: [String: String] = [:]
            
            for (index, element) in arrayOfNames.enumerated(){
                self.notesArray[element] = arrayOfNotes[index] as! String
            }
            
            
            print(self.notesArray)
            
                for note in 1...test{
                    self.notes = arrayOfNames
                }
            
            }
            
            
            self.tableView.reloadData()
        })
        
       
     
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
            UIColor.gray.cgColor,UIColor.cyan.cgColor]
        return layer
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let note = self.notes[indexPath.row]
        cell.textLabel?.text = note
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        cell.selectedBackgroundView = backgroundView
//        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = Storyboard.instantiateViewController(withIdentifier: "CurrentNoteVC") as! CurrentNoteVC
        
        vc2.getNoteName = notes[indexPath.row] as! String
        vc2.getNoteText = notesArray[notes[indexPath.row]]!
        self.present(vc2, animated: true)
    }
    
  
    
    func addTextField(){
        let txtTest = UITextField(frame: CGRect(x: 20.0, y: 300.0, width: 200.0 , height: 80.0))
        txtTest.backgroundColor = .white
        self.view.addSubview(txtTest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        try! Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
//        self.dismiss(animated: true, completion: nil)
   }
    

}


