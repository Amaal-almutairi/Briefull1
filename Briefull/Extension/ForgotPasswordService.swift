//
//  ForgotPasswordService.swift
//  Briefull
//
//  Created by Ghada Amer Alshahrani on 23/07/1444 AH.
//
import Combine
import Foundation
import FirebaseAuth


protocol ForgotPasswordService{
    func sendPaswwordReset(to email:String) -> AnyPublisher<Void,Error>
}

final class ForgotPasswordServiceEmpl: ForgotPasswordService{
    func sendPaswwordReset(to email:String) -> AnyPublisher<Void,Error> {
        Deferred {
            Future { Promise in
                Auth
                    .auth()
                    .sendPasswordReset(withEmail: email) { error in
                        if let err = error{
                            Promise(.failure(err))
                        } else {
                            Promise(.success(()))
                        }
                        
                    }
                
            }
        }
        .eraseToAnyPublisher()
    }
    
}
