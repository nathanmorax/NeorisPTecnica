//
//  APIService.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//

import Combine
import SwiftUI

class APIService {
    
    static let shared = APIService()
    private let baseURL = "https://jsonplaceholder.typicode.com/photos"
    private var cancellables = Set<AnyCancellable>()
    private let cache = NSCache<NSString, NSData>()
    
    func fetchPhotos() -> AnyPublisher<[PhotoResponse], Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PhotoResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        if let cachedData = cache.object(forKey: urlString as NSString) {
            return Just(UIImage(data: cachedData as Data))
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { [weak self] response -> UIImage? in
                self?.cache.setObject(response.data as NSData, forKey: urlString as NSString)
                return UIImage(data: response.data)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

