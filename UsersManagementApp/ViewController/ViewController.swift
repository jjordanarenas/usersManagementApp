//
//  ViewController.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var userTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var detailPopup: DetailPopupView?
    let viewModel = UserManagementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindings()
        self.initializeTableView()
        self.viewModel.fetchUsers()
        self.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New User", style: .plain, target: self, action: #selector(self.addTapped))
    }

    private func bindings() {
        self.viewModel.userList.addObserver(fireNow: false) { [weak self] userList in
            self?.userTableView.reloadData()
        }
    }

    private func initializeTableView() {
        self.userTableView.dataSource = self
        self.userTableView.delegate = self
        self.userTableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
    }

    @objc private func addTapped() {
        self.hideRightBarButtonItem() 
        self.showDetailPopup() 
    }

    func hideRightBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }

    func addRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New User", style: .plain, target: self, action: #selector(self.addTapped))
    }


}
