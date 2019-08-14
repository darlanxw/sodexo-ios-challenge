//
//  UIView+Extensions.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

extension UIView {
    
    func setRoundedCorner(_ cornerRadius: CGFloat = 8.0) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
    
}
