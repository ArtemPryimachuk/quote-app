//
//  ViewController.swift
//  quote-app
//
//  Created by Artem on 28.01.2024.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    
    let phrasesListKey = "usedPhrasesListKey"
    let quoteCreatedAt = "quoteCreatedAtKey"
    
    var phrasesList: [String] = ["Stay focused and never give up.",
                                 "Hard work beats talent when talent doesn't work hard.",
                                 "Believe in yourself and all that you are.",
                                 "Your only limit is you.",
                                 "Dream big, work hard, stay focused.",
                                 "Success is not final, failure is not fatal: It is the courage to continue that counts.",
                                 "The only way to do great work is to love what you do.",
                                 "Don't watch the clock; do what it does. Keep going.",
                                 "Success is stumbling from failure to failure with no loss of enthusiasm.",
                                 "You are never too old to set another goal or to dream a new dream.",
                                 "The only place where success comes before work is in the dictionary.",
                                 "Challenges are what make life interesting and overcoming them is what makes life meaningful.",
                                 "The future belongs to those who believe in the beauty of their dreams.",
                                 "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.",
                                 "Your time is limited, don't waste it living someone else's life.",
                                 "In the middle of difficulty lies opportunity.",
                                 "The harder the battle, the sweeter the victory.",
                                 "Your attitude determines your direction.",
                                 "Believe you can and you're halfway there.",
                                 "Don't be afraid to give up the good to go for the great.",
                                 "The only thing standing between you and your goal is the story you keep telling yourself as to why you can't achieve it.",
                                 "If you want to achieve greatness stop asking for permission.",
                                 "Do it with passion or not at all.",
                                 "Success is not just about making money. It's about making a difference.",
                                 "Don't stop when you're tired. Stop when you're done.",
                                 "The only person you are destined to become is the person you decide to be.",
                                 "Don't wait for opportunity. Create it.",
                                 "It's not about how bad you want it. It's about how hard you're willing to work for it.",
                                 "The only limit to our realization of tomorrow will be our doubts of today.",
                                 "The only way to achieve the impossible is to believe it is possible."
    ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setPhrase()
    }
    
    func generatePhrase() -> String? { // фраза рандом + масив
        guard phrasesList.count > 0 else{
            return nil
        }
        var usedPhrasesList: [String] = UserDefaults.standard.stringArray(forKey: phrasesListKey) ?? [String]()
        let availiblePhrase = phrasesList.filter {!usedPhrasesList.contains($0)}
        guard !availiblePhrase.isEmpty else {
            return nil
        }
        let randomI = Int.random(in: 0..<availiblePhrase.count)
        let phraseOfDay = availiblePhrase[randomI]
        usedPhrasesList.append(phraseOfDay)
        UserDefaults.standard.set(usedPhrasesList, forKey: phrasesListKey)
        UserDefaults.standard.synchronize()
        return phraseOfDay
    }
    
    func isTimeChanged() -> Bool {
        let currentDate = Date()
        guard let lastTime = UserDefaults.standard.value(forKey: quoteCreatedAt) as? Date else {
            return true
        }
        let lastTimeToCompare = lastTime.zeroSeconds
        let currentTimeToCompare = currentDate.zeroSeconds
        
        if lastTimeToCompare != currentTimeToCompare {
            return true
        }else {
            return false
        }
    }
    
    func saveQuoteCreationDate() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: quoteCreatedAt)
        UserDefaults.standard.synchronize()
    }
    
    func getLastQuote() -> String? {
        let usedPhrasesList = UserDefaults.standard.array(forKey: phrasesListKey) as? [String] ?? []
        let lastQuote = usedPhrasesList.last
        return lastQuote
    }
    
    func setPhrase() {
        if isTimeChanged() == true {
            let newQuote = generatePhrase()
            saveQuoteCreationDate()
            quoteLabel.text = newQuote
        }else {
            let lastQuote = getLastQuote()
            quoteLabel.text = lastQuote
        }
    }
}
