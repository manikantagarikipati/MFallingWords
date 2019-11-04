//
//  File.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

public protocol DomainError: Error {
    var description: String { get }
}

extension DomainError {
    var string: String {
        return self as? String ?? description
    }
}

