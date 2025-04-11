//
//  ViewModel.swift
//  DemoAsync
//
//  Created by Alok Kumar on 11/04/25.
//

import ALKAsyncNetwork
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var failed: [String: String] = [:]
    
    private var networkManager: ALKNetworkManager?
    
    init() {
        networkManager = ALKNetworkManager(config: Config())
    }
    
    @MainActor
    func getProducts() async {
        guard let networkManager = networkManager else { return }
        
        do {
            products = try await networkManager.request([Product].self, request: ProductRequest())
        } catch {
            failed = ["Error": error.localizedDescription]
        }
    }
}

struct Product: Decodable, Identifiable, Hashable {
    let id: Int
    let title, description, category: String
    let price: Double
    let image: URL
}

struct Config: NetworkConfig {
    var urlCache: URLCache? {
        URLCache(
            memoryCapacity: 10 * 1024 * 1024,
            diskCapacity: 10 * 1024 * 1024,
            diskPath: "MyDemoAppCache"
        )
    }
    
    var session: URLSession {
        let config = URLSessionConfiguration.default
        config.urlCache = urlCache
        return URLSession(configuration: config)
    }
}

struct ProductRequest: `Request` {
    var method: RequestMethod = .get
    
    func make() -> URLRequest {
        let url = URL(string: "https://fakestoreapi.com/products")!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return request
    }
}
