//
//  RealmModels.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

import RealmSwift

class RealmCategory: Object {
    @objc dynamic var listName: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var listNameEncoded: String = ""
    
    convenience init(category: Category) {
        self.init()
        self.listName = category.listName
        self.displayName = category.displayName
        self.listNameEncoded = category.listNameEncoded
    }
}

class RealmBook: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var bookImage: String = ""
    @objc dynamic var bookDescription: String = ""
    @objc dynamic var publisher: String = ""
    @objc dynamic var rank: Int = 0
    
    convenience init(book: Book) {
        self.init()
        self.title = book.title
        self.author = book.author
        self.bookImage = book.bookImage.absoluteString
        self.bookDescription = book.description
        self.publisher = book.publisher
        self.rank = book.rank
    }
}
