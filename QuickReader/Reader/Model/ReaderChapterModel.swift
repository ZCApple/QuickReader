//
//  ReaderChapterModel.swift
//  QuickReader
//
//  Created by zhangcanming on 2023/8/13.
//

import Foundation
import ObjectMapper

class ReaderChapterModel: BaseModel {
    
    var title: String?
    var content: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title      <- map["title"]
        content    <- map["content"]
    }
}
