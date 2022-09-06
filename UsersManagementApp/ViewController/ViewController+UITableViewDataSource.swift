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
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        guard let unwrappedCell = cell else {
            fatalError("Error on dequeueReusableCell")
        }
        let user = self.viewModel.userList.value[indexPath.row]

        unwrappedCell.nameLabel.text = user.name
        unwrappedCell.idLabel.text = user.id
        unwrappedCell.birthdayLabel.text = user.birthDate

        return unwrappedCell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.viewModel.deleteUserWithId((tableView.cellForRow(at: indexPath) as? CustomCell)?.idLabel.text ?? "")
            self.viewModel.userList.value.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
