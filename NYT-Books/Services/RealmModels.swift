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
    let books = List<RealmBook>()

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
    @objc dynamic var category: RealmCategory?
    @Persisted var buyLinks = List<RealmBuyLink>()


    convenience init(book: Book) {
        self.init()
        self.title = book.title
        self.author = book.author
        self.bookImage = book.bookImage.absoluteString
        self.bookDescription = book.description
        self.publisher = book.publisher
        self.rank = book.rank
        let realmBuyLinks = book.buyLinks.map { RealmBuyLink(buyLink: $0) }
        buyLinks.append(objectsIn: realmBuyLinks)
    }
}


class RealmBuyLink: Object {
    @Persisted var name: String = ""
    @Persisted var urlString: String = ""

    convenience init(buyLink: BuyLink) {
        self.init()
        self.name = buyLink.name
        self.urlString = buyLink.url.absoluteString
    }
}
