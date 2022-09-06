//
//  UserManagementViewModel.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class UserManagementViewModel {
    var userList = Observable<[UserDisplay]>(value: [])

    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      return dateFormatter
    }()

    func fetchUsers() {
        APIService.fetchUsers(complete: { [weak self] (success, userList, error) in
            self?.userList.value = userList.map {
                UserDisplay(id: String($0.id), name: $0.name ?? "", birthDate: self?.dateFormatter.string(from: $0.birthDate) ?? "")
            }
        })
    }
}
