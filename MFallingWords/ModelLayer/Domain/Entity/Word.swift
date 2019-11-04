//
//  Word.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

public struct Word{
    let original: String
    let translations: [Translation]
    var translation: String {
        return translations.first!.title
    }
}
