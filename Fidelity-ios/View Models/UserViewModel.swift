//
//  UserViewModel.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation

class UserViewModel {
    var user: User?
    
    init(with model: User) {
        self.user = model
    }
}
