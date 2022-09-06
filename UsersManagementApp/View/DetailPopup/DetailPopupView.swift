//
//  DetailPopup.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation
import UIKit

class DetailPopupView: UIView {
    var userDetailViewModel = UserDetailViewModel()

    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    class var identifier: String { return String(describing: self) }

    class func instanceFromNib() -> DetailPopupView {
        let detailPopupView = UINib(nibName: identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0]
        as! DetailPopupView
        detailPopupView.initializeView()

        return detailPopupView
    }

    func initializeView() {
        self.bindings()
    }

    @IBAction func saveUser(_ sender: Any) {
        self.userDetailViewModel.nameDetail.value = self.fullNameTextField.text ?? ""
        self.userDetailViewModel.birthdateDetail.value = self.datePicker.date
        self.userDetailViewModel.isCreatingNewUser = false
        self.userDetailViewModel.updateUserWithId(self.userDetailViewModel.idDetail.value, name: self.userDetailViewModel.nameDetail.value, birthDate: self.userDetailViewModel.birthdateDetail.value)
    }

    private func bindings() {
        self.userDetailViewModel.nameDetail.addObserver(fireNow: false) { [weak self] userName in
            self?.fullNameTextField.text = userName
        }
        self.userDetailViewModel.birthdateDetail.addObserver(fireNow: false) { [weak self] birthDay in
            // TODO work properly with date
            //self?.datePicker.date = Date(from: birthDay)
            self?.datePicker.date = Date()
        }
    }
}
