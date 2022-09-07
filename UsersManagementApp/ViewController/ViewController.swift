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

    // MARK: - Public functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindings()
        self.initializeTableView()
        self.viewModel.fetchUsers()
        self.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New User", style: .plain, target: self, action: #selector(self.addTapped))
    }

    func hideRightBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }

    func addRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New User", style: .plain, target: self, action: #selector(self.addTapped))
    }

    func showDetailPopup() {
        self.initializeDetailPopup(isEditing: false)
        self.detailPopup?.isHidden = false
    }

    func initializeDetailPopup(isEditing: Bool) {
        if self.detailPopup == nil {
            self.detailPopup = DetailPopupView.instanceFromNib()
            self.detailPopup!.frame = self.view.frame
            self.view.addSubview(self.detailPopup!)
            self.detailPopup?.userDetailViewModel.delegate = self
        }

        if isEditing {
            self.detailPopup?.userDetailViewModel.isCreatingNewUser = false
            self.detailPopup?.isEditingUser()
        } else {
            self.detailPopup?.userDetailViewModel.isCreatingNewUser = true
            self.detailPopup?.isCreatingNewUser()
        }
    }
    
    // MARK: - Private functions
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
}
