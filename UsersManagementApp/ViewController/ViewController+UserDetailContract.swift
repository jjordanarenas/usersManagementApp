//
//  ViewController+UserDetailContract.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 8/9/22.
//

import Foundation

extension ViewController: UserDetailContract {
    func userAddedOrEditedSuccessfully() {
        sleep(1)
        self.viewModel.fetchUsers()
    }

    func closeDetailPopup() {
        self.addRightBarButtonItem()
    }
}
