//
//  UserManagementViewModel.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class UserManagementViewModel {
    var userList = Observable<[UserDisplay]>(value: [])

    let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      return dateFormatter
    }()

    // MARK: - Public functions
    func fetchUsers() {
        APIService.fetchUsers(complete: { [weak self] (success, userList, error) in
            self?.userList.value = userList.map {
                UserDisplay(id: String($0.id), name: $0.name ?? "", birthDate: self?.dateFormatter.string(from: $0.birthDate) ?? "")
            }
        })
    }

    func deleteUserWithId(_ id: String) {
        APIService.deleteUser(id: id) { success in
            if !success {
                fatalError("Error deleting user with id \(id)")
            }
        }
    }

    func searchUser(by name: String) {
        self.userList.value = self.userList.value.filter {
            $0.name.contains(name)
        }
    }
}
