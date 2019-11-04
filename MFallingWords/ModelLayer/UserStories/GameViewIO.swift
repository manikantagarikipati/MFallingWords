//
//  GameViewIO.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import RxCocoa

public protocol GameViewIO: ViewIO {
    
    ///when rightbutton is pressed
    var rightPressed: Driver<Int> {get}
    
    ///wron button is pressed
    var wrongPressed: Driver<Int>{ get}
    
    ///no button is pressed.
    var didNotHit: Action{get}
    
    /// Update score in Game object and word for next round when score animations are finished
    var updateData: Driver<Int> { get }
    
    var newGame: Action { get }
    
    /// Show new word
    func showWord(_ word: Word, duration: CFTimeInterval)
    
    /// Update user's score
    func updateScore(isAdding: Bool, newScore: Int)
    
    /// Show alert of ending game
    func endGame(_ didWin: Bool)
    
    /// Show error
    func showError(_ error: DomainError)
}
