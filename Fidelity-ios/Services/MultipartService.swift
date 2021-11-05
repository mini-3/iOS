//
//  MultipartService.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 27/10/21.
//

import Foundation

struct MultipartService {
    static private let ABSOLUTE_PATH = "http://localhost:3000"
    
    static public func post<T:Codable>(path: String, image: Data, data: [String: AnyHashable], type: T.Type, handler: @escaping (Result<T, WebServiceError>) -> Void) {
        guard let url = URL(string: "\(ABSOLUTE_PATH)\(path)") else { handler(.failure(.badUrlError)); return }
        
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: []) else { handler(.failure(.parsingJsonError)); return }
        
        let boundary = "---011000010111000001101001"
        let body = buildBody(image: image, data: data, boundary: boundary)
       
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body as Data?
       
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
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
    
    static private func buildBody(image: Data, data: Data, boundary: String) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"data\"\r\n")
        body.appendString("\r\n")
        body.append(data)
        body.appendString("\r\n")
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
        body.appendString("\r\n")
        body.append(image)
        body.appendString("\r\n")
        
        //close
        body.appendString("--" + boundary + "--\r\n")
        print("body:", body)
        return body as Data
    }
}
