//
//  ViewController.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = UserManagementViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchUsers()
    }
}
