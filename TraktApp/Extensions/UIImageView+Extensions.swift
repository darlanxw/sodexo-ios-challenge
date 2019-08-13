//
//  UIImageView+Extensions.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(url: String) {
        if (url.isEmpty) {
            self.backgroundColor = UIColor.black
            return
        }
        
        let fullUrl = UIApplication.tmdbImageRootUrl.appending(url)
        let remoteImageUrl = URL(string: fullUrl)!
        
        DispatchQueue.global().async {
            Alamofire.request(remoteImageUrl).responseData { [weak self] (response) in
                guard let strongSelf = self else { return }
                if response.error == nil {
                    if let data = response.data {
                        strongSelf.image = UIImage(data: data)
                        strongSelf.layoutSubviews()
                    }
                }
            }
        }        
    }
}
