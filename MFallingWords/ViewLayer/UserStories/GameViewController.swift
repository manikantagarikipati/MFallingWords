//
//  GameViewController.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var originalWordLabel: UILabel!
    @IBOutlet weak var pointsView: PointsView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    @IBOutlet weak var plusScoreLabel: UILabel!
    @IBOutlet weak var minusScoreLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let viewModel = GameViewModel<GameViewController>()
    private let updateDataSignal = PublishSubject<Int>()
    private let newGameSignal = PublishSubject<Void>()
    private let rightSignalScore = PublishSubject<Int>()
    private let wrongSignalScore = PublishSubject<Int>()
    
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       viewModel.attachView(viewIO: self).disposed(by: disposeBag)
       progressBar.greenWidth.constant = progressBar.frame.width / 2
   }

    @IBAction func rightButtonPressed(_ sender: Any) {
        let plusScore = pointsView.stopFalling()
        rightSignalScore.onNext(plusScore)
    }
    
    @IBAction func wrongButtonPressed(_ sender: Any) {
        let plusScore = pointsView.stopFalling()
        wrongSignalScore.onNext(plusScore)
    }

}

extension GameViewController: GameViewIO {
    var rightPressed: Driver<Int> {
        return rightSignalScore.asDriver(onErrorDriveWith: .never())
    }
    
    var wrongPressed: Driver<Int> {
        return wrongSignalScore.asDriver(onErrorDriveWith: .never())
    }
    
    var didNotHit: Action {
        return pointsView.didNotHitSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var updateData: Driver<Int> {
        return updateDataSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var newGame: Action {
        return newGameSignal.asDriver(onErrorDriveWith: .never())
    }
    
    func showWord(_ word: Word, duration: CFTimeInterval) {
        originalWordLabel.text = word.original
        pointsView.newFall(with: word.translation, duration: duration)
    }
    
    func updateScore(isAdding: Bool, newScore: Int) {
        let plusScore = pointsView.stopFalling()
        isAdding ?
            addPoints(newScore: newScore, pointsAdding: plusScore) :
            subtractPoints(newScore)
    }
    
    func endGame(_ didWin: Bool) {
        let title = didWin ? "You win!" : " You lose :("
        endGameAlert(title: title)
    }
    
    func showError(_ error: DomainError) {
        let alert = UIAlertController(title: "Error", message: error.string, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Helper methods

extension GameViewController {
    
    private func addPoints(newScore: Int, pointsAdding: Int) {
        plusScoreLabel.text = "+\(pointsAdding)"
        animateScoreUpdate(plusScoreLabel, score: newScore)
    }
    
    private func subtractPoints(_ points: Int) {
        animateScoreUpdate(minusScoreLabel, score: points)
    }
    
    private func animateScoreUpdate(_ label: UILabel, score: Int) {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.view.isUserInteractionEnabled = false
            label.alpha = 1
        }, completion: { [unowned self] _ in
            self.progressBar.updateScore(score)
            self.scoreLabel.text = "Your score: \(score)"
            UIView.animate(withDuration: 0.3, animations: {
                label.alpha = 0
            }, completion: { [unowned self] _ in
                self.updateDataSignal.onNext(score)
                self.view.isUserInteractionEnabled = true
            })
        })
    }
    
    private func endGameAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Want to try again?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sure!", style: .default, handler: { [unowned self] action in
            self.startNewGame()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func startNewGame() {
        self.newGameSignal.onNext(())
        self.progressBar.greenWidth.constant = self.progressBar.frame.width / 2
        self.scoreLabel.text = "Your score: 0"
    }
}
