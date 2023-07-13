//
//  NetworkService.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit


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
    
    func fetchBooks(name: String) async throws -> BooksListResponse {
        guard let url = URL(string: "\(baseURL)lists/current/\(name).json?api-key=\(token)") else {
            print("url error")
            throw NetworkServiceError.invalidURL
        }
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Network service error")
            throw NetworkServiceError.serverError
        }
        do {
            let booksListResponse = try JSONDecoder().decode(BooksListResponse.self, from: data)
            return booksListResponse
        } catch let decodeError {
            print("Failed to decode JSON:", decodeError)
            print("Data received: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
            throw decodeError // rethrow the error to the caller function
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
