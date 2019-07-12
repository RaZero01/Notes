//
//  Note.swift
//  Notes
//
//  Created by Konstantin Razinkov on 09/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit
import Foundation

class Note {

    var id: String
    var user: UserModel
    var text: String
    var createdAt: Date
    
    init(id: String, user: UserModel, text: String, timestamp: Double){
        self.id = id
        self.user = user
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }

}
