//
//  User.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

struct User: Codable {
    let name: String?
    let birthDate: Date
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case birthDate = "birthdate"
    }
}

struct Users: Codable {
    let userList: [User]
}
