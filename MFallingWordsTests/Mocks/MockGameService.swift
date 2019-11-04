//
//  MockGameService.swift
//  MFallingWordsTests
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import MFallingWords
import RxSwift

class MockGameService: GameService {
    
    var _gerWords: Observable<[JSONWord]>!
    func getWords() -> Observable<[JSONWord]> { return _gerWords }
    
}
