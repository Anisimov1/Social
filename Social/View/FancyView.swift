//
//  FancyView.swift
//  Social
//
//  Created by Anthony Anisimov on 12/27/17.
//  Copyright © 2017 Anthony Anisimov. All rights reserved.
//

import UIKit

class FancyView: UIView {
//change class identifier for top purple square to FancyView
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
