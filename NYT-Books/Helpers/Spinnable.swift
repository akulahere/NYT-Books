//
//  Spinnable.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

typealias Completion<T> = (T) -> Void

protocol Spinnable {

    associatedtype SpinnerType: Spinner

    func showSpinner()
    func showSpinner(configure: Completion<SpinnerType.SpinnerView>?)

    func hideSpinner()
    func hideSpinner(configure: Completion<SpinnerType.SpinnerView>?)
}

extension Spinnable where Self: UIView {

    func showSpinner() {
        self.showSpinner(configure: nil)
    }

    func hideSpinner() {
        self.hideSpinner(configure: nil)
    }

    func showSpinner(configure: Completion<SpinnerType.SpinnerView>?) {
        SpinnerService.show(on: self, provider: SpinnerType.self, configure: configure)
    }

    func hideSpinner(configure: Completion<SpinnerType.SpinnerView>?) {
        SpinnerService.hide(from: self, provider: SpinnerType.self, configure: configure)
    }
}

