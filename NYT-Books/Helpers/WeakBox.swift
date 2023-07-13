//
//  WeakBox.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

class WeakBox<T: AnyObject> {
    weak var wrapped: T?
    
    init(_ value: T) {
        wrapped = value
    }
}
