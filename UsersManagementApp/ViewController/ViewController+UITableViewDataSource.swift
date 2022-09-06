//
//  ViewController+UITableViewDataSource.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userList.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = self.viewModel.userList.value[indexPath.row]

        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.id)

        return cell
    }
}
