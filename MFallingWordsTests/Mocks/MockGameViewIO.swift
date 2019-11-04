//
//  MockGameViewIO.swift
//  MFallingWordsTests
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import MFallingWords
import RxSwift
import RxCocoa

class MockGameViewIO: GameViewIO {
    
    var _didNotHit = PublishSubject<Void>()
    var didNotHit: Action { return _didNotHit.asDriver(onErrorDriveWith: .never()) }
    
    var _updateData = PublishSubject<Int>()
    var updateData: Driver<Int> { return _updateData.asDriver(onErrorDriveWith: .never()) }
    
    var _rightPressed = PublishSubject<Int>()
    var rightPressed: Driver<Int> { return _rightPressed.asDriver(onErrorDriveWith: .never()) }
    
    var _wrongPressed = PublishSubject<Int>()
    var wrongPressed: Driver<Int> { return _wrongPressed.asDriver(onErrorDriveWith: .never()) }
    
    var _newGame = PublishSubject<Void>()
    var newGame: Action { return _newGame.asDriver(onErrorDriveWith: .never()) }
    
    var _showWord: (Word, CFTimeInterval) -> Void = { _,_ in }
    func showWord(_ word: Word, duration: CFTimeInterval) { _showWord(word, duration) }
    
    var _updateScore: (Bool, Int) -> Void = { _,_ in }
    func updateScore(isAdding: Bool, newScore: Int) { _updateScore(isAdding, newScore) }
    
    var _endGame: (Bool) -> Void = { _ in }
    func endGame(_ didWin: Bool) { _endGame(didWin) }
    
    var _showError: (DomainError) -> Void = { _ in }
    func showError(_ error: DomainError) { _showError(error) }
}
