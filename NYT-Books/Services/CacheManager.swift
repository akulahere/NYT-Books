//
//  CacheManager.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

import RealmSwift

class CacheManager {
    static let shared = CacheManager()
    private let realm = try! Realm()
    private let realmQueue = DispatchQueue(label: "realmQueue")
    
    func saveCategories(_ categories: [Category]) {
        realmQueue.async {
            let realm = try! Realm()
            do {
                try realm.write {
                    let realmCategories = categories.map { RealmCategory(category: $0) }
                    realm.add(realmCategories)
                }
            } catch {
                print("Error saving categories: \(error)")
            }
        }
    }
    
    // Retrieving categories from the cache
    func getCategories() -> [Category] {
        var categories: [Category] = []

        realmQueue.sync {
                let realm = try! Realm()
                let realmCategories = realm.objects(RealmCategory.self)
                categories = realmCategories.map { Category(realmCategory: $0) }
        }
        
        return categories
    }
    
    // Saving books to the cache
    func saveBooks(_ books: [Book], forCategory categoryName: String) {
        realmQueue.async {
            do {
                let realm = try Realm()
                try realm.write {
                    let realmCategory = realm.objects(RealmCategory.self).filter("listNameEncoded == %@", categoryName).first
                    let realmBooks = books.map {
                        let realmBook = RealmBook(book: $0)
                        realmBook.category = realmCategory
                        realmCategory?.books.append(realmBook)
                        return realmBook
                    }
                    print("BOOKS SAVED")
                    realm.add(realmBooks)
                }
            } catch {
                print("Error saving books: \(error)")
            }
        }
    }


    
    func getBooks(forCategory categoryName: String) -> [Book] {
        realmQueue.sync {
            let realm = try! Realm()
            let realmCategory = realm.objects(RealmCategory.self).filter("listNameEncoded == %@", categoryName).first
            let realmBooks = realmCategory?.books ?? List<RealmBook>()
            return realmBooks.map { Book(realmBook: $0) }
        }
    }

}
