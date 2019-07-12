//
//  UserModel.swift
//  Notes
//
//  Created by Konstantin Razinkov on 09/10/2018.
//  Copyright © 2018 RaZero01. All rights reserved.
//

import UIKit

class UserModel {

    var id: String?
    var username: String?
    var email: String?
    
    init(id: String?, username: String?, email: String?) {
        self.id = id
        self.username = username
        self.email = email
    }
    
}
