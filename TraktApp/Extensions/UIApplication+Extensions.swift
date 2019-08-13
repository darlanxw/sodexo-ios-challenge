//
//  UIApplication+Extensions.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var traktUrlRoot: String {
        return Bundle.main.object(forInfoDictionaryKey: "TraktUrlRoot") as? String ?? ""
    }
    
    static var tmdbImageRootUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "TMDBImageUrlRoot") as? String ?? ""
    }
    
    static var tmdbUrlRoot: String {
        return Bundle.main.object(forInfoDictionaryKey: "TMDBUrlRoot") as? String ?? ""
    }
    
    static var traktApiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "TraktApiKey") as? String ?? ""
    }
    
    static var traktApiVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "TraktApiVersion") as? String ?? "2"
    }
    
    static var tmdbApiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "TMDBKey") as? String ?? ""
    }
}
