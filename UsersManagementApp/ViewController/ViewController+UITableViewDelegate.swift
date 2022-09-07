//
//  ViewController+UITableViewDelegate.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.viewModel.userList.value[indexPath.row]

        self.initializeDetailPopup(isEditing: true)

        self.detailPopup!.userDetailViewModel.nameDetail.value = user.name
        self.detailPopup!.userDetailViewModel.idDetail.value = user.id

        let date = viewModel.dateFormatter.date(from: user.birthDate)!
        self.detailPopup!.userDetailViewModel.birthdateDetail.value = date
    }

    private func initializeDetailPopup(isEditing: Bool) {
        if self.detailPopup == nil {
            self.detailPopup = DetailPopupView.instanceFromNib()
            self.detailPopup!.frame = self.view.frame
            self.view.addSubview(self.detailPopup!)
        }

        if isEditing {
            self.detailPopup?.userDetailViewModel.isCreatingNewUser = false
            self.detailPopup?.isEditingUser()
        } else {
            self.detailPopup?.userDetailViewModel.isCreatingNewUser = true
            self.detailPopup?.isCreatingNewUser()
        }
    }

    func showDetailPopup() {
        self.initializeDetailPopup(isEditing: false)
        self.detailPopup?.isHidden = false
    }
}
