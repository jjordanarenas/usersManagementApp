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
    var isEditing = false

    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    
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
        self.userDetailViewModel.saveUser(self.userDetailViewModel.idDetail.value, name: self.userDetailViewModel.nameDetail.value, birthDate: self.userDetailViewModel.birthdateDetail.value)
        self.closePopup()
    }

    @IBAction func closeDetailPopup(_ sender: Any) {
        self.closePopup()
    }

    private func closePopup() {
        self.isHidden = true
    }

    private func bindings() {
        self.userDetailViewModel.nameDetail.addObserver(fireNow: false) { [weak self] userName in
            self?.fullNameTextField.text = userName
        }
        self.userDetailViewModel.birthdateDetail.addObserver(fireNow: false) { [weak self] birthDay in
            self?.datePicker.date = birthDay
        }
    }

    func isCreatingNewUser() {
        self.idLabel.isHidden = false
        self.idTextField.isHidden = false
        self.fullNameTextField.text = ""
        self.idTextField.text = ""
        self.datePicker.date = Date()

        self.isHidden = false
    }

    func isEditingUser() {
        self.idLabel.isHidden = true
        self.idTextField.isHidden = true

        self.isHidden = false
    }
}
