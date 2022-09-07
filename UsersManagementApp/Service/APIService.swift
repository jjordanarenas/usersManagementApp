//
//  APIService.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class APIService {
    static var API_URL = "https://hello-world.innocv.com/api/User"
    static func fetchUsers(complete: @escaping ( _ success: Bool, _ userList: [User], _ error: Error? )->()) {
        guard let fetchUsersUrl = URL(string: self.API_URL) else { return }
            DispatchQueue.global().async {
               URLSession.shared.dataTask(with: fetchUsersUrl){
                   data, response, error in

                   if error != nil {
                       print(error?.localizedDescription ?? "Error fetching users")
                       return
                   }

                   let decoder = JSONDecoder()

                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                   decoder.dateDecodingStrategy = .formatted(dateFormatter)

                   if let data = data {
                       do {
                           let users = try decoder.decode([User].self, from: data)
                           complete(true, users, error)
                       } catch{
                           print("Error fetching users \(error)")
                       }
                   }
               }.resume()
            }
    }

    static func deleteUser(id: String, complete: @escaping ( _ success: Bool)->()) {
        guard let deleteUserUrl = URL(string: self.API_URL + "/\(id)") else { return }
            var request = URLRequest(url: deleteUserUrl)
            request.httpMethod = "DELETE"
            DispatchQueue.global().async {
               URLSession.shared.dataTask(with: request){
                   data, response, error in

                   if error != nil {
                       print(error?.localizedDescription ?? "Error deleting user")
                       return
                   }

                   if data != nil {
                       complete(true)
                   } else {
                       complete(false)
                   }
               }.resume()
            }
    }

    static func editUser(id: Int, name: String, birthDate: Date, complete: @escaping ( _ success: Bool)->()) {
        guard let editUserUrl = URL(string: self.API_URL) else { return }

        let userDataModel = User(name: name, birthDate: birthDate, id: id)

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted , .sortedKeys]
        encoder.dateEncodingStrategy = .secondsSince1970

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        encoder.dateEncodingStrategy = .formatted(dateFormatter)


        guard let data = try? encoder.encode(userDataModel) else {
            print("Error: Trying to convert userDataModel to JSON data")
            return
        }

        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                              print("Error: Cannot convert data to JSON object")
                              return
                          }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }

            var request = URLRequest(url: editUserUrl)
            request.httpMethod = "PUT"
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]

            URLSession.shared.uploadTask(with: request, from: prettyJsonData) { (responseData, response, error) in
                if let error = error {
                    print("Error making PUT request: \(error.localizedDescription)")
                    complete(false)
                    return
                }

                if let responseCode = (response as? HTTPURLResponse)?.statusCode, let _ = responseData {
                    guard responseCode == 200 else {
                        print("Invalid response code: \(responseCode)")
                        complete(false)
                        return
                    }

                    complete(true)
                }
            }.resume()
        } catch{
            print("Error editing user")
        }
    }

    static func addUser(id: Int, name: String, birthDate: Date, complete: @escaping ( _ success: Bool)->()) {
        guard let editUserUrl = URL(string: self.API_URL) else { return }

        let userDataModel = User(name: name, birthDate: birthDate, id: id)

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted , .sortedKeys]
        encoder.dateEncodingStrategy = .secondsSince1970

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        encoder.dateEncodingStrategy = .formatted(dateFormatter)


        guard let data = try? encoder.encode(userDataModel) else {
            print("Error: Trying to convert userDataModel to JSON data")
            return
        }

        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                              print("Error: Cannot convert data to JSON object")
                              return
                          }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }

            var request = URLRequest(url: editUserUrl)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]

            URLSession.shared.uploadTask(with: request, from: prettyJsonData) { (responseData, response, error) in
                if let error = error {
                    print("Error making PUT request: \(error.localizedDescription)")
                    complete(false)
                    return
                }

                if let responseCode = (response as? HTTPURLResponse)?.statusCode, let _ = responseData {
                    guard responseCode == 200 else {
                        print("Invalid response code: \(responseCode)")
                        complete(false)
                        return
                    }

                    complete(true)
                }
            }.resume()
        } catch{
            print("Error editing user")
        }
    }
}
