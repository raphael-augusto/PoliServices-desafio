//
//  Networking.swift
//  PoliServices
//
//  Created by Raphael Augusto on 07/02/23.
//

import UIKit
import Foundation


protocol NetworkingProtocol {
    func load<T: Decodable> (endpoint: NetworkingEndPoint, completion: @escaping (Result<T, NetworkinError>) -> Void)
    func post<T: Decodable> (endpoint: NetworkingEndPoint, parameters: [String: Any],completion: @escaping (Result<T, NetworkinError>) -> Void)
}

struct Networking: NetworkingProtocol {
    
    private var session: URLSession
    private let baseURL = "https://run.mocky.io/v3/"
    
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func load<T>(
        endpoint: NetworkingEndPoint,
        completion: @escaping (Result<T, NetworkinError>) -> Void
    ) where T : Decodable {
        
        guard let url = URL(string: baseURL + "\(endpoint.rawValue)") else {
            return completion(.failure(.invalidURL))
        }
        
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                return completion(.failure(.errorGeneric(description: error.localizedDescription)))
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                return completion(.failure(.invalidResponse))
            }
            
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
    
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                
                if let result = try? decoder.decode(T.self, from: data) {
                    completion(.success(result))
                    
                } else {
                    print("-- Service --")
                    completion(.failure(.errorDecoder))
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    func post<T>(
            endpoint: NetworkingEndPoint,
            parameters: [String: Any],
            completion: @escaping (Result<T, NetworkinError>) -> Void
        ) where T : Decodable {
            
            guard let url = URL(string: baseURL + "\(endpoint.rawValue)") else {
                return completion(.failure(.invalidURL))
            }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                return completion(.failure(.invalidData))
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    return completion(.failure(.errorGeneric(description: error.localizedDescription)))
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    return completion(.failure(.invalidResponse))
                }
                
                
                guard let data = data else {
                    return completion(.failure(.invalidData))
                }
        
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let result = try decoder.decode(T.self, from: data)
                    
                    completion(.success(result))
                } catch {
                    print("-- Service --")
                    completion(.failure(.errorDecoder))
                    print("errorDecoder -> \(error)")
                }
            }
            
            dataTask.resume()
        }
}
