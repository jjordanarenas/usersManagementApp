//
//  UserDetailViewModel.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class UserDetailViewModel {
    var isCreatingNewUser = true
    var idDetail = Observable<String>(value: "")
    var nameDetail = Observable<String>(value: "")
    var birthdateDetail = Observable<Date>(value: Date())
    var delegate: UserDetailContract?

    func saveUser(_ id: String, name: String, birthDate: Date) {
        if self.isCreatingNewUser {
            APIService.addUser(id: Int(id) ?? 0, name: name, birthDate: birthDate){ success in
                if !success {
                    fatalError("Error updating user with id \(id)")
                } else {
                    self.delegate?.userAddedOrEditedSuccessfully()
                }
            }
        } else {
            APIService.editUser(id: Int(id) ?? 0, name: name, birthDate: birthDate){ success in
                if !success {
                    fatalError("Error updating user with id \(id)")
                } else {
                    self.delegate?.userAddedOrEditedSuccessfully()
                }
            }
        }
    }
}
