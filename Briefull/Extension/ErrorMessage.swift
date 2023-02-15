//
//  ErrorMessage.swift
//  Briefull
//
//  Created by Amaal Almutairi on 15/07/1444 AH.
//

import Foundation

enum FBError: Error, Identifiable {
    case error(String)
    
    var id: UUID {
        UUID()
    }
    
    var errorMessage: String {
        switch self {
            case .error(let message):
                return message
        }
    }
}

