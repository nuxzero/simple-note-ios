//
//  NetworkService.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 23/1/2564 BE.
//

import Foundation

enum NetworkError: Error {
    case noInternetConection
    case emptyResponse
    case parseDataFailed
}

class NetworkService {
    
    static let apiUrl = "https://blooming-falls-95246.herokuapp.com"
    static let shared = NetworkService()
    
    func send<T: Decodable>(_ request: Request<T>, completionHandler: @escaping (Result<T, Error>) -> Void) {
        var urlRequest: URLRequest
        do {
            urlRequest = try buildURLRequest(request)
        } catch {
            completionHandler(.failure(error))
            return
        }
    
        let  dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            var result: Result<T, Error>
            defer {
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }
            
            if let error = error {
                result = .failure(error)
            }
            
            guard let data = data else {
                print("Data is empty.")
                result = .failure(NetworkError.emptyResponse)
                return
            }
            
            do {
                let res = try self.decodeData(T.self, data: data)
                result = .success(res)
            } catch {
                result = .failure(error)
            }
        }
        dataTask.resume()
    }
    
    private func decodeData<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(type, from: data)
            print(result)
            return result
        } catch {
            print(error)
            throw NetworkError.parseDataFailed
        }
    }
    
    func buildURLRequest<T>(_ request: Request<T>) throws -> URLRequest {
        guard let url = URL(string: "\(NetworkService.apiUrl)/\(request.path)") else {
            fatalError("Invalid URL.")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if (request.method != .get) {
            urlRequest.httpBody = Data() // TODO: set body
        }
        return urlRequest
    }
}
