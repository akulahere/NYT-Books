//
//  Category.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct Category: Codable {
    let listName: String
    let displayName: String
    let listNameEncoded: String
    
    init(realmCategory: RealmCategory) {
        self.listName = realmCategory.listName
        self.displayName = realmCategory.displayName
        self.listNameEncoded = realmCategory.listNameEncoded
    }
    
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
    }
}
