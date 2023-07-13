//
//  CircleSpinner.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

class CircleSpinner: Spinner {
    typealias SpinnerView = UIActivityIndicatorView
    
    static func preparedSpinner() -> SpinnerView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .blue
        spinner.startAnimating()
        return spinner
    }
}
