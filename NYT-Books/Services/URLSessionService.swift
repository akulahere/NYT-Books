//
//  URLSessionService.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 14.07.2023.
//

import UIKit

protocol URLSessionServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
    func fetchImage(from url: URL) async throws -> UIImage
}

class URLSessionService: URLSessionServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NetworkServiceError.decodingError(description: "Failed to recognize Image")
        }
        return image
    }
}
