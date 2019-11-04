//
//  GameViewModelTests.swift
//  MFallingWordsTests
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import XCTest
import RxSwift

@testable import MFallingWords

class GameViewModelTests: XCTestCase {
    
    var words = [JSONWord]()
    var sut: GameViewModel<MockGameViewIO>!
    var viewIO: MockGameViewIO!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        sut = GameViewModel()
        viewIO = MockGameViewIO()
        words = [
            JSONWord(original: "primary school", translation: "escuela primaria"),
            JSONWord(original: "teacher", translation: "profesor / profesora"),
            JSONWord(original: "pupil", translation: "alumno / alumna"),
            JSONWord(original: "holidays", translation: "vacaciones"),
            JSONWord(original: "class", translation: "curso"),
            JSONWord(original: "bell", translation: "timbre"),
            JSONWord(original: "group", translation: "grupo"),
            JSONWord(original: "exercise book", translation: "cuaderno"),
            JSONWord(original: "quiet", translation: "quieto"),
            JSONWord(original: "(to) answer", translation: "responder"),
            JSONWord(original: "groheadteacherup", translation: "director del colegio / directora del colegio")
        ]
    }
    
    func testWordShuffling() {
        // Given
        var wordsShuffled = false
        var shuffled = [Bool]()
        
        // When game starts
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        // Shuffle original array
        let shuffledWords = sut.shuffleWords(words)
        
        // Check words at the same indexes between two arrays
        for index in 0...6 {
            let originalWord = words[index].original
            let shuffledWord = shuffledWords[index].original
            shuffled.append(originalWord != shuffledWord)
        }
        
        // Check that more than half is shuffled
        wordsShuffled = shuffled.filter { $0 == true }.count > shuffled.count/2
        
        // Then
        XCTAssertTrue(wordsShuffled)
    }
    
    func testProbabilityOfCorrectMatch() {
        // Given
        var reasonableProbability = false
        viewIO._showWord = { word,_ in
            // Check first 3 translations and make sure that one of them is correct
            for index in 0...2 {
                if reasonableProbability { break }
                reasonableProbability = word.translations[index].isRight
            }
        }
        
        // When game starts and words are shuffled
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        // Then
        XCTAssertTrue(reasonableProbability)
    }
    
    func testRightButton() {
        // Given
        var previousScore = 0
        viewIO._updateScore = { isAdding, prevScore in previousScore = prevScore }

        // When game starts and words are shuffled
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)

        // Press right button
        viewIO._rightPressed.onNext((previousScore))

        // Wait for animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Test that score changed after first button pressed
            let scoreAfterButtonPress = self?.sut.game.value.score
            self?.eventually { XCTAssertNotEqual(scoreAfterButtonPress, previousScore) }
        }
    }
    
    func testWrongButton() {
        // Given
        var previousScore = 0
        viewIO._updateScore = { isAdding, prevScore in previousScore = prevScore }
        
        // When game starts
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        // Press right button
        viewIO._wrongPressed.onNext((previousScore))
        
        // Wait for animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Test that score changed after first button pressed
            let scoreAfterButtonPress = self?.sut.game.value.score
            self?.eventually { XCTAssertNotEqual(scoreAfterButtonPress, previousScore) }
        }
    }
    
    func testDidNotHit() {
        // Given
        var previousScore = 0
        viewIO._updateScore = { isAdding, prevScore in previousScore = prevScore }
        
        // When game starts
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        // Wait for the word falling + animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
            guard let `self` = self else { return }
            // Test that after not hitting the button score was subtracted by 100 points
            let scoreAfterNotHittingButtons = self.sut.game.value.score
            let scoreChange = scoreAfterNotHittingButtons - previousScore
            self.eventually {
                XCTAssertEqual(scoreChange, -100)
            }
        }
    }
    
    func testEndGame() {
        // Given
        var endGameAlertWasShown = false
        viewIO._endGame = { _ in endGameAlertWasShown = true }
        
        // When game starts
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        // Change game score to -900
        sut.game.value.score = -900
        
        // Wait for the word falling + animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
            // Check if endGame() was called
            self?.eventually { XCTAssertTrue(endGameAlertWasShown) }
        }
    }
    
}
