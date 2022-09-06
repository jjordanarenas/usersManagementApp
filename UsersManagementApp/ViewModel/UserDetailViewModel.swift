//
//  UserDetailViewModel.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class UserDetailViewModel {
    var isCreatingNewUser = false
    var idDetail = Observable<String>(value: "")
    var nameDetail = Observable<String>(value: "")
    var birthdateDetail = Observable<Date>(value: Date())

    func updateUserWithId(_ id: String, name: String, birthDate: Date) {
        if isCreatingNewUser {
            APIService.addUser(id: Int(id) ?? 0, name: name, birthDate: birthDate){ success in
                if !success {
                    fatalError("Error updating user with id \(id)")
                }
            }
        } else {
            APIService.editUser(id: Int(id) ?? 0, name: name, birthDate: birthDate){ success in
                if !success {
                    fatalError("Error updating user with id \(id)")
                }
            }
        }
    }
}
