//
//  Button.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
}