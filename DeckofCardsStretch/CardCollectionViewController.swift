//
//  CardCollectionViewController.swift
//  DeckofCardsStretch
//
//  Created by Evan Peterson on 2/3/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cards"

class CardCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        CardController.shared.draw { (isSucces, error) in
            if error != nil {
                NSLog("Error loading deck")
                return
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }

    }

  


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardController.shared.cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let cards = CardController.shared.cards[indexPath.row]
        ImageController.image(forURL: cards.image) { (image) in
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 108)
            
            cell.contentView.addSubview(imageView)
        }
        
    
        return cell
    }

    @IBAction func AddCardButtonTapped(_ sender: Any) {
        CardController.shared.draw { (isSucces, error) in
            if error != nil {
                NSLog("Error adding card")
                return
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
   }
}
