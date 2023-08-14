//
//  BaseModel.swift
//  QuickReader
//
//  Created by zhangcanming on 2023/8/13.
//

import Foundation
import ObjectMapper

class BaseModel: NSObject {
    
    override init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
}
