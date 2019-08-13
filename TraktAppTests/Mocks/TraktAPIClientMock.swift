//
//  TraktAPIClientMock.swift
//  TraktApp
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation
@testable import TraktApp

class TraktAPIClientMock: TraktAPIClientProtocol {
    
    var apiWasExecuted = false
    var hasError = false
    
    func requestList<T>(_ request: T, completion: @escaping (ResultList<DataListContainer<T.Response>>) -> Void) where T : APIRequest {
        apiWasExecuted = true
        
        if (hasError) {
            completion(.failure("Error"))
            return
        }
        
        let list = get(jsonFileName: request.mockPath)
        let decoder = JSONDecoder()
        if let data = list {
            do {
                let response = try decoder.decode([T.Response].self, from: data)
                completion(.success(response))
            }
            catch let error {
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func requestObject<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        
    }
    
    private func get(jsonFileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json") else {
            fatalError("Missing file: \(jsonFileName).json")
        }
        do {
            return try Data(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func unbox<G: Decodable>(_ json: Data) throws -> G {
        return try JSONDecoder().decode(G.self, from: json)
    }
}
