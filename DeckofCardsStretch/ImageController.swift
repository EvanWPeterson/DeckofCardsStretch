//
//  ImageController.swift
//  DeckofCardsStretch
//
//  Created by Evan Peterson on 2/3/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import UIKit


class ImageController {
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else { fatalError("image URL optional is nil")
            
        }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            guard let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            DispatchQueue.main.async {
                
                completion(image)
                
            }
            
        }
    }
}
