//
//  ViewController.swift
//  Concentration
//
//  Created by Amin  on 24/10/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var flipCounts = 0
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            self.flipCounts += 1
            flipCountLabel.text = "Flip count: \(flipCounts)"
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in card buttons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = (card.isMatched) ? .clear : .orange
            }
        }
    }
    
    var emojiChoices = ["👻", "😎", "😁", "😋", "🤓", "🤪", "😜", "🥰"]
    var emoji = Dictionary<Int, String>()
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int (arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

