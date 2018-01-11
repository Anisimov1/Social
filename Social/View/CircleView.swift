//
//  CircleView.swift
//  Social
//
//  Created by Anthony Anisimov on 12/30/17.
//  Copyright © 2017 Anthony Anisimov. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
