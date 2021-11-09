//
//  WebService.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import Foundation

public enum WebServiceError: Error {
    case badUrlError
    case parsingJsonError
    case noDataError
}

public struct WebService {
    static private let ABSOLUTE_PATH = Constants.API_PATH
    
    // MARK: - Get
    static public func get<T:Codable>(path: String, type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: "\(ABSOLUTE_PATH)\(path)") else { handler(.failure(.badUrlError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data  else { handler(.failure(.noDataError)); return }
            
            //guard let data = try? JSONDecoder().decode(T.self, from: data) else { handler(.failure(.parsingJsonError)); return }

            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                handler(.success(data))
            } catch {
                print(error)
                handler(.failure(.parsingJsonError))
            }
            
        }
        .resume()
    }
    
    // MARK: - Post
    static public func post<T:Codable>(path: String, body: [String: AnyHashable], type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: "\(ABSOLUTE_PATH)\(path)") else { handler(.failure(.badUrlError)); return }
        
        guard let body = try? JSONSerialization.data(withJSONObject: body, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else { handler(.failure(.noDataError)); return }
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                handler(.success(data))
            } catch {
                print(error)
                handler(.failure(.parsingJsonError))
            }
        }
        .resume()
    }
    
    // MARK: - Put
    static public func put<T:Codable>(path: String, body: [String: AnyHashable], type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: "\(ABSOLUTE_PATH)\(path)") else { handler(.failure(.badUrlError)); return }
        
        guard let body = try? JSONSerialization.data(withJSONObject: body, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(SessionService.shared.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else { handler(.failure(.noDataError)); return }

            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                handler(.success(data))
            } catch {
                print(error)
                handler(.failure(.parsingJsonError))
            }
        }
        .resume()
    }
    
    // MARK: - Delete
    static public func delete<T:Codable>(path: String, type: T.Type, handler: @escaping (Result<Int, WebServiceError>) -> Void) {
        guard let url = URL(string: "\(ABSOLUTE_PATH)\(path)") else { handler(.failure(.badUrlError)); return }
        
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
