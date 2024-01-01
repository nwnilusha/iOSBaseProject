//
//  ApiService.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import Foundation

struct ApiService {
    let urlString: String
    
    func getJSON<T: Decodable>(dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        guard
            let url = URL(string: urlString)
        else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            
            let decorder = JSONDecoder()
            decorder.dateDecodingStrategy = dateDecodingStategy
            decorder.keyDecodingStrategy = keyDecodingStategy
            do {
                let decodeData = try decorder.decode(T.self, from: data)
                return decodeData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    func getJSON<T: Decodable>(dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                keyDecodingStategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                Completion: @escaping (Result<T,APIError>) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            Completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                Completion(.failure(.invalidResponseStatus))
                return
            }
            guard
                error == nil
            else {
                Completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard
                let data = data
            else {
                Completion(.failure(.curruptData))
                return
            }
            
            let decorder = JSONDecoder()
            decorder.dateDecodingStrategy = dateDecodingStategy
            decorder.keyDecodingStrategy = keyDecodingStategy
            do {
                let decodeData = try decorder.decode(T.self, from: data)
                Completion(.success(decodeData))
            } catch {
                Completion(.failure(.decodingError(error.localizedDescription)))
            }
        }
        .resume()
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case curruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The APIO failed to issue a valid response", comment: "")
        case .dataTaskError(let string):
            return string
        case .curruptData:
            return NSLocalizedString("The data Provided appers to be currupted", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}
