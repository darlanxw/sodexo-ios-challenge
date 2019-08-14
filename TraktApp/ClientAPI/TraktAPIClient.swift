//
//  TraktAPIClient.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public class TraktAPIClient: TraktAPIClientProtocol {
    
    func requestList<T>(_ request: T, completion: @escaping (ResultList<DataListContainer<T.Response>>) -> Void) where T : APIRequest {
        
        let endpoint: URLRequest
        
        do {
            endpoint = try getRequest(for: request, url: UIApplication.traktUrlRoot)
        } catch let error{
            completion(.failure(error.localizedDescription))
            return
        }
        
        Alamofire.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(responseData.error?.localizedDescription ?? "Failure on getting response from server."))
                return
            }
            
            do {
                let response = try JSONDecoder().decode([T.Response].self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func requestObject<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        
        let endpoint: URLRequest
        
        do {
            endpoint = try getRequest(for: request, url: UIApplication.tmdbUrlRoot, false)
        } catch let error{
            completion(.failure(error.localizedDescription))
            return
        }        
        
        Alamofire.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(responseData.error?.localizedDescription ?? "Failure on getting response from server."))
                return
            }
            
            let stringer = String(data: data, encoding: .utf8)
            print(stringer ?? "")
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    internal func getRequest<T: APIRequest>(for request: T, url: String, _ isTrakt: Bool = true) throws -> URLRequest {
        guard let baseURL = URL(string: request.path, relativeTo: URL(string: url)) else {
            fatalError("Bad resource name: \(request.path)")
        }
        
        print(baseURL.absoluteString)        
        
        var requestData = URLRequest(url: baseURL)
        
        requestData.httpMethod = HTTPMethod.get.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (isTrakt) {
            getTraktHeader(&requestData)
        }
        
        return requestData
    }
    
    fileprivate func getTraktHeader(_ requestData: inout URLRequest) {
        requestData.addValue(UIApplication.traktApiVersion, forHTTPHeaderField: "trakt-api-version")
        requestData.addValue(UIApplication.traktApiKey, forHTTPHeaderField: "trakt-api-key")
    }
}
