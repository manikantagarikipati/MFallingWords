//
//  File.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import RxSwift

class LocalGameService: GameService{
    func getWords() -> Observable<[JSONWord]> {
        return Observable.create { observer in
            if let path = Bundle.main.path(forResource: "words", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let words = try JSONDecoder().decode([JSONWord].self, from: data)
                    observer.onNext(words)
                } catch {
                    observer.onError(ErrorCase.parseError)
                }
            } else {
                observer.onError(ErrorCase.invalidJSONPath)
            }
            return Disposables.create()
        }
    }
}
