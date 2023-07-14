//
//  SpinnerService.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

class SpinnerService {

    private static var spinners = [UIView : WeakBox<UIView>]()

    static func show<ProviderType: Spinner, Type>(
        on view: UIView,
        provider: ProviderType.Type,
        configure: Completion<Type>?
    )
        where ProviderType.SpinnerView == Type
    {
        guard self.spinners[view] == nil else {
            return
        }

        let spinner = provider.preparedSpinner()

        if let viewUnwrapped = WeakBox(view).wrapped {
            self.spinners[viewUnwrapped] = WeakBox(spinner)
        }

        view.addSubview(spinner)

        configure?(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: spinner.frame.height),
            spinner.widthAnchor.constraint(equalToConstant: spinner.frame.width)
        ])
    }

    static func hide<ProviderType: Spinner, Type>(
        from view: UIView,
        provider: ProviderType.Type,
        configure: Completion<Type>?
    ) {
        let spinner = self.spinners.removeValue(forKey: view)

        spinner?.wrapped?.removeFromSuperview()
    }
}
