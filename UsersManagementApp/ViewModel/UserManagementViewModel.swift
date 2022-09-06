//
//  UserManagementViewModel.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class UserManagementViewModel {
    var userList = Observable<[User]>(value: [])

    func fetchUsers() {
        APIService.fetchUsers(complete: { [weak self] (success, userList, error) in
            self?.userList.value = userList
        })
    }
}
