//
//  DataContainer.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}

public struct DataListContainer<ResultList: Decodable> : Decodable {
    public let resultList: ResultList
}
