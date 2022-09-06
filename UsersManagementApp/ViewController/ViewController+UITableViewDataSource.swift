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
        unwrappedCell.idLabel.text = String(user.id)
        
        return unwrappedCell
    }
}
