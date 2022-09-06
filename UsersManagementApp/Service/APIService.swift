//
//  APIService.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class APIService {
    func fetchUsers(complete: @escaping ( _ success: Bool, _ userList: [User], _ error: Error? )->()) {
        guard let fetchUsersUrl = URL(string: "https://hello-world.innocv.com/api/User") else { return }
            DispatchQueue.global().async {
               URLSession.shared.dataTask(with: fetchUsersUrl){
                   data, response, error in

                   if error != nil {
                       print(error?.localizedDescription)
                       return
                   }

                   let decoder = JSONDecoder()

                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                   decoder.dateDecodingStrategy = .formatted(dateFormatter)

                   if let data = data {
                       do {
                           let users = try decoder.decode([User].self, from: data)
                           users.forEach{ user in
                               print("User name:\(user.name) - id :\(user.id)")
                           }
                       } catch{
                           print("Error fetching users \(error)")
                       }
                   }
               }.resume()
            }
    }
}