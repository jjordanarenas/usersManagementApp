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
        self.detailPopup!.userDetailViewModel.birthdateDetail.value = Date()
        // TODO work properly with date
        //self.detailPopup!.userDetailViewModel.birthdateDetail.value = user.birthDate
    }

    private func initializeDetailPopup(isEditing: Bool) {
        if self.detailPopup == nil {
            self.detailPopup = DetailPopupView.instanceFromNib()
            self.detailPopup!.frame = self.view.frame
            self.view.addSubview(self.detailPopup!)
        }

        if isEditing {
            self.detailPopup?.isEditingUser()
        } else {
            self.detailPopup?.isCreatingNewUser()
        }
    }

    func showDetailPopup() {
        self.initializeDetailPopup(isEditing: false)
        self.detailPopup?.isHidden = false
    }

    func hideDetailPopup() {
        self.detailPopup?.isHidden = true
    }
}
