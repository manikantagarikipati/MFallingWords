//
//  Game.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import Foundation

class Game {
    private var words: [Word]
    var score = 0
    
    init(words: [Word]) {
        self.words = words
    }
    
    var currentWord: Word {
        return words.first!
    }
    
    //just to make it a bit competetive!!
    var fallDuration: CFTimeInterval {
        if score > 700 { return 2 }
        else if score > 500 { return 3 }
        else if score > 300 { return 4 }
        else { return 5 }
    }
    
    func updateCurrentWord() -> Word {
        let firstWord = currentWord
        words.removeFirst()
        words.append(firstWord)
        return currentWord
    }

    func updateTranslation() -> Word{
        let firstWord = words.first!
        var translations = firstWord.translations
        let first = translations.first!
        if first.isRight {
            translations.removeFirst()
            translations.insert(first, at: Int(arc4random_uniform(3)))
            let word = Word(original: firstWord.original, translations: translations)
            updateFirstWord(word)
            return updateCurrentWord()
        }
        translations.removeFirst()
        translations.append(first)
        let word = Word(original: firstWord.original, translations: translations)
        updateFirstWord(word)
        return currentWord
    }
    
    private func updateFirstWord(_ updatedWord: Word) {
        words.removeFirst()
        words.insert(updatedWord, at: 0)
    }
    
}
