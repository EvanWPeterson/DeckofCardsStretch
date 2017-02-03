//
//  CardController.swift
//  DeckofCardsStretch
//
//  Created by Evan Peterson on 2/3/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class CardController {
    
    static let shared = CardController()
    var cards: [Cards] = []
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=5")
    
     func draw(completion: @escaping(Bool, Error?) -> Void) {
        
        guard let baseURL = CardController.baseURL else { fatalError("URL was nil") }
        
        NetworkController.performRequest(for: baseURL, httpMethod: .Get) { (data, error) in
            guard let data = data
                else {
                    NSLog("No data reutrn from the network")
                    completion(false, nil)
                    return
            }
            
            if error != nil {
                NSLog("Error while loading new deck")
                completion(false, error)
                return
            }
            
            guard let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else {
                NSLog("Error serializing")
                completion(false, error)
                return
            }
            
            guard let cardsDictionary = dictionary["cards"] as? [[String:Any]] else {
                NSLog("Error retrieving cards")
                completion(false, error)
                return
            }
            
            for cardDictionary in cardsDictionary {
                guard let card = Cards(dictionary: cardDictionary) else {
                    NSLog("Error creating deck")
                    completion(false, error)
                    return
                }
                    self.cards.append(card)
                }
            completion(true, nil)

            
        }
    }
    
}
