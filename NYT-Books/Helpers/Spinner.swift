//
//  Spinner.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

protocol Spinner {
    associatedtype SpinnerView: UIView
    static func preparedSpinner() -> SpinnerView
}
