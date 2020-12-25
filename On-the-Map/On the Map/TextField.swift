//
//  TextField.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/8/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 20, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 20, 0)
    }
}