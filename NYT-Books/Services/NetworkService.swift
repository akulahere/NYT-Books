//
//  NetworkService.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation


protocol NetworkServiceProtocol {

}


class NetworkService: NetworkServiceProtocol {
    
    // MARK: -
    // MARK: Variables

    private let baseURL: String
    private let token: String


    // MARK: -
    // MARK: Initialization
    
    init(baseURL: String = "https://api.nytimes.com/svc/books/v3/", token: String = "ZRRgQ8cHos6TN6JwAP3KwSWUACYGAHLU") {
        self.baseURL = baseURL
        self.token = token
    }
    
    // MARK: -
    // MARK: Public

    func fetchCategories() async throws -> CategoriesResponse {
        guard let url = URL(string: "\(baseURL)/lists/names.json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.serverError
        }

        let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
        return categoriesResponse
    }
    
    func fetchCustomCategory(name: String) async throws -> BooksListResponse {
        guard let url = URL(string: "\(baseURL)/lists/current/\(name).json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.serverError
        }

        let booksListResponse = try JSONDecoder().decode(BooksListResponse.self, from: data)
        return booksListResponse
    }
}

enum NetworkServiceError: Error {
    case invalidURL
    case serverError
    case decodingError
}
