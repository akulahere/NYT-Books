//
//  NetworkService.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit


protocol NetworkServiceProtocol {
    func fetchCategories() async throws -> CategoriesResponse
    func fetchBooks(name: String) async throws -> BooksListResponse
    func fetchImage(from url: URL) async throws -> UIImage
}


class NetworkService: NetworkServiceProtocol {
    
    private let baseURL: String
    private let token: String
    
    init(baseURL: String = "https://api.nytimes.com/svc/books/v3/", token: String = "ZRRgQ8cHos6TN6JwAP3KwSWUACYGAHLU") {
        self.baseURL = baseURL
        self.token = token
    }
    
    func fetchCategories() async throws -> CategoriesResponse {
        guard let url = URL(string: "\(baseURL)/lists/names.json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.serverError
        }
        do {
            let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            return categoriesResponse
        } catch {
            throw NetworkServiceError.decodingError
        }
    }
    
    func fetchBooks(name: String) async throws -> BooksListResponse {
        guard let url = URL(string: "\(baseURL)lists/current/\(name).json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.serverError
        }
        
        do {
            let booksListResponse = try JSONDecoder().decode(BooksListResponse.self, from: data)
            return booksListResponse
        } catch {
            throw NetworkServiceError.decodingError
        }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NetworkServiceError.decodingError
        }
        return image
    }
}

enum NetworkServiceError: Error {
    case invalidURL
    case serverError
    case decodingError
}
