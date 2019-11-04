//
//  ErrorCase.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

enum ErrorCase: DomainError {
    
    case parseError
    case invalidJSONPath
    
    var description: String {
        switch self {
        case .parseError:
            return "Error Performing JSON Parsing"
        case .invalidJSONPath:
            return "Invalid JSON filename or path"
        }
    }
}
