//
//  TraktAPIClientProtocol.swift
//  TraktApp
//
//  Created by objective on 08/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

protocol TraktAPIClientProtocol {
    func requestList<T: APIRequest>(_ request: T, completion: @escaping ResultListCallback<DataListContainer<T.Response>>)
    func requestObject<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}
