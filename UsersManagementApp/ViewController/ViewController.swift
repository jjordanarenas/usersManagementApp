//
//  ViewController.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var userTableView: UITableView!

    let viewModel = UserManagementViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindings()
        self.initializeTableView()

        self.viewModel.fetchUsers()
    }

    private func bindings() {
        self.viewModel.userList.addObserver(fireNow: false) { [weak self] userList in
            self?.userTableView.reloadData()
        }
    }

    private func initializeTableView() {
        self.userTableView.dataSource = self
        self.userTableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
    }
}
