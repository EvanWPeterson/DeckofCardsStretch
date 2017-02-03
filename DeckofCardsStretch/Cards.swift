//
//  Cards.swift
//  DeckofCardsStretch
//
//  Created by Evan Peterson on 2/3/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class Cards {
    
    private static let kValue = "value"
    private static let kImage = "image"
    
    let value: String
    let image: String
    
    init(value: String, image: String) {
        self.value = value
        self.image = image
    }
    
    convenience init?(dictionary: [String:Any]) {
        guard let value = dictionary[Cards.kValue] as? String,
            let image = dictionary[Cards.kImage] as? String else { return nil}
        
        self.init(value: value, image: image)
        
    }
    
    
}
