//
//  WebService.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

enum WebServiceError: Error {
    case badUrlError
    case parsingJsonError
    case noDataError
}

struct WebService {
    
    // MARK:- Get
    static func get<T:Codable>(path: String, type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data  else { handler(.failure(.noDataError)); return }
            
            guard let data = try? JSONDecoder().decode(T.self, from: data) else { handler(.failure(.parsingJsonError)); return }

            handler(.success(data))
        }
        .resume()
    }
    
    // MARK:- Post
    static func post<T:Codable>(path: String, body: [String: AnyHashable], type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        guard let body = try? JSONSerialization.data(withJSONObject: body, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else { handler(.failure(.noDataError)); return }

            guard let data = try? JSONDecoder().decode(T.self, from: data) else { handler(.failure(.parsingJsonError)); return }
            
            handler(.success(data))
        }
        .resume()
    }
    
    // MARK:- Put
    static func put<T:Codable>(path: String, body: [String: AnyHashable], type: T.Type, handler: @escaping (Result<Int, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        guard let body = try? JSONSerialization.data(withJSONObject: body, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let response = response, let httpResponse = response as? HTTPURLResponse else { handler(.failure(.noDataError)); return }

            handler(.success(httpResponse.statusCode))
        }
        .resume()
    }
    
    // MARK:- Delete
    static func delete<T:Codable>(path: String, type: T.Type, handler: @escaping (Result<Int, WebServiceError>) -> Void) {
        guard let url = URL(string: path) else { handler(.failure(.badUrlError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let response = response, let httpResponse = response as? HTTPURLResponse else { handler(.failure(.noDataError)); return }

            handler(.success(httpResponse.statusCode))
        }
        .resume()
    }

}
