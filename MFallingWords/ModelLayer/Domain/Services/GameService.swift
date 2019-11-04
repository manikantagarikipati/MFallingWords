//
//  GameService.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import RxSwift

public protocol GameService {
    func getWords() -> Observable<[JSONWord]>
}
