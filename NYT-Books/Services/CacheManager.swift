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
    
    // Saving categories to the cache
    func saveCategories(_ categories: [Category]) {
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
        let realmCategories = realm.objects(RealmCategory.self)
        return realmCategories.map { Category(realmCategory: $0) }
    }
    
    // Saving books to the cache
    func saveBooks(_ books: [Book]) {
        do {
            try realm.write {
                let realmBooks = books.map { RealmBook(book: $0) }
                realm.add(realmBooks)
            }
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    // Retrieving books from the cache
    func getBooks() -> [Book] {
        let realmBooks = realm.objects(RealmBook.self)
        return realmBooks.map { Book(realmBook: $0) }
    }
}
