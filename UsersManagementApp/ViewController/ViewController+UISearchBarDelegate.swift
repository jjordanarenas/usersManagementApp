//
//  ViewController+UISearchBarDelegate.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 8/9/22.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let userName = searchBar.text else { return }
      self.viewModel.searchUser(by: userName)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
    //items = films
      self.viewModel.fetchUsers()
  }
}
