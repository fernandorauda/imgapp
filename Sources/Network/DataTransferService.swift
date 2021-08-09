//
//  DataTransferService.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import RxSwift
import RxCocoa

public enum DataConvertError: Error {
    case noResponse
    case parsing(Error?)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public protocol DataConvertErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public protocol DataConvertService {
    typealias CompletionHandler<T> = (Result<T, DataConvertError>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> Void where E.Response == T
}


public final class DataConvertServiceDefault: DataConvertService {
    
    private let networkService: NetworkService
    private let errorResolver: DataConvertErrorResolver
    
    public init(with networkService: NetworkService,
                errorResolver: DataConvertErrorResolver = DataConvertErrorResolverDefault()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> Void where E.Response == T {
            networkService.request(endpoint: endpoint) { result in
                switch result {
                case .success(let data):
                    let result: Result<T, DataConvertError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                    DispatchQueue.main.async { return completion(result) }
                case .failure(let error):
                    let error = self.resolve(networkError: error)
                    DispatchQueue.main.async { return completion(.failure(error)) }
                }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataConvertError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataConvertError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}


// MARK: - Error Resolver
public class DataConvertErrorResolverDefault: DataConvertErrorResolver {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}
