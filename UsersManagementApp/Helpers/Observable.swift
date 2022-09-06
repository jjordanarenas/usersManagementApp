//
//  Observable.swift
//  UsersManagementApp
//
//  Created by Jorge Jordán on 6/9/22.
//

import Foundation

class Observable<T> {
    private var valueChanged: ((T) -> Void)?
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    init(value: T) {
        self.value = value
    }

    func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
        self.valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }

    func removeObserver() {
        self.valueChanged = nil
    }
}
