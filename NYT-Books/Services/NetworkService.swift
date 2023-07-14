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
    private let urlSessionService: URLSessionServiceProtocol
    
    init(baseURL: String = "https://api.nytimes.com/svc/books/v3/",
         token: String = "ZRRgQ8cHos6TN6JwAP3KwSWUACYGAHLU",
         urlSessionService: URLSessionServiceProtocol = URLSessionService())
    {
        self.baseURL = baseURL
        self.token = token
        self.urlSessionService = urlSessionService
    }
    
    func fetchCategories() async throws -> CategoriesResponse {
        guard let url = URL(string: "\(baseURL)/lists/names.json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL(description: "Invalid URL for fetching categories.")
        }
        
        do {
            return try await urlSessionService.fetchData(from: url)
        } catch {
            throw NetworkServiceError.serverError(description: "Failed to fetch categories. \(error.localizedDescription)")
        }
    }
    
    func fetchBooks(name: String) async throws -> BooksListResponse {
        guard let url = URL(string: "\(baseURL)lists/current/\(name).json?api-key=\(token)") else {
            throw NetworkServiceError.invalidURL(description: "Invalid URL for fetching books.")
        }
        
        do {
            return try await urlSessionService.fetchData(from: url)
        } catch {
            throw NetworkServiceError.serverError(description: "Failed to fetch books. \(error.localizedDescription)")
        }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        do {
            return try await urlSessionService.fetchImage(from: url)
        } catch {
            throw NetworkServiceError.decodingError(description: "Failed to fetch image. \(error.localizedDescription)")
        }
    }
}

enum NetworkServiceError: Error {
    case invalidURL(description: String)
    case serverError(description: String)
    case decodingError(description: String)
}
