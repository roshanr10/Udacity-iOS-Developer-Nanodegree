//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Roshan Ravi on 6/13/15.
//  Copyright (c) 2015 Innovate Loop Enterprises. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(title: String?, file: NSURL!){
        self.title = title
        self.filePathUrl = file
    }
}