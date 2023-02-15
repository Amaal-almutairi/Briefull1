//
//  SignUpViewModel.swift
//  Briefull
//
//  Created by Amaal Almutairi on 15/07/1444 AH.
//

import Foundation
import FirebaseAuth


class SignUpViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
            
        }
        
    }
    
}
