//
//  CacheManager.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

import RealmSwift

actor CacheManager {
    static let shared = CacheManager()
    private let realm = try! Realm()
    
    func saveCategories(_ categories: [Category]) {
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
    
    // Retrieving categories from the cache
    func getCategories() -> [Category] {
        var categories: [Category] = []

                let realm = try! Realm()
                let realmCategories = realm.objects(RealmCategory.self)
                categories = realmCategories.map { Category(realmCategory: $0) }
        
        return categories
    }
    
    // Saving books to the cache
    func saveBooks(_ books: [Book], forCategory categoryName: String) {
            do {
                let realm = try Realm()
                try realm.write {
                    let realmCategory = realm.objects(RealmCategory.self).filter("listNameEncoded == %@", categoryName).first
                    let existingBookTitles = Set(realmCategory?.books.map { $0.title } ?? [])
                    
                    let newBooks = books.filter { !existingBookTitles.contains($0.title) }
                    let realmBooks = newBooks.map { book -> RealmBook in
                        let realmBook = RealmBook(book: book)
                        realmBook.category = realmCategory
                        realmCategory?.books.append(realmBook)
                        return realmBook
                    }
                    realm.add(realmBooks)
                }
            } catch {
                print("Error saving books: \(error)")
            }
    }
    
    func getBooks(forCategory categoryName: String) -> [Book] {
            let realm = try! Realm()
            let realmCategory = realm.objects(RealmCategory.self).filter("listNameEncoded == %@", categoryName).first
            let realmBooks = realmCategory?.books ?? List<RealmBook>()
            return realmBooks.map { Book(realmBook: $0) }
        }

}
