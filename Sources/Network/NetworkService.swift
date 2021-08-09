//
//  NetworkService.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler)
}

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler)
}

// MARK: - Implementation

public final class NetworkServiceDefault{
    
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    
    public init(config: NetworkConfigurable,
                sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.sessionManager = sessionManager
        self.config = config
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) {
        sessionManager.request(request) { data, response, requestError in
                if let requestError = requestError {
                    var error: NetworkError
                    if let response = response as? HTTPURLResponse {
                        error = .error(statusCode: response.statusCode, data: data)
                    } else {
                        error = self.resolve(error: requestError)
                    }
                    
                    completion(.failure(error))
                } else {
                    completion(.success(data))
                }
            }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension NetworkServiceDefault: NetworkService {
    
    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
        }
    }
}

public class DefaultNetworkSessionManager: NetworkSessionManager {
    public init() {}
    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
