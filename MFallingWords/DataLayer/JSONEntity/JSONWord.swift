//
//  JSONWord.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

public struct JSONWord: Decodable{
    
    let original: String
    let translation: String
    
    enum CodingKeys: String,CodingKey {
        case original = "text_eng"
        case translation = "text_spa"
    }
    
    public init(original: String, translation: String) {
        self.original = original
        self.translation = translation
    }
}
