//
//  APIRequest.swift
//  TraktApp
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
    
    var path: String { get }
    var mockPath: String { get }
    
    associatedtype Response: APIResponse
}
