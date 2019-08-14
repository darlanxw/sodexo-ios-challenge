//
//  Result.swift
//  TraktApp
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(String)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void

public enum ResultList<Value> {
    case success([APIResponse]?)
    case failure(String)
}

typealias ResultListCallback<Value> = (ResultList<Value>) -> Void
