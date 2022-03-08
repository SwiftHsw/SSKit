//
//  SBaseModel.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit
import KakaJSON


protocol Copyable: Codable {
    func clone() -> Self
}

extension Copyable {
    
    func clone() -> Self {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            fatalError("encode失败")
        }
        let decoder = JSONDecoder()
        guard let target = try? decoder.decode(Self.self, from: data) else {
           fatalError("decode失败")
        }
        return target
    }
    
}


class SBaseModel: NSObject,Convertible {

    
    
    required override init() {
        
    }
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name
    }
    
    
}
