//
//  ForgotPasswordViewModel.swift
//  Briefull
//
//  Created by Ghada Amer Alshahrani on 23/07/1444 AH.
//

import Foundation
import Combine

protocol ForgotPasswordViewModel {
    func sendPaswwordReset()
    var service : ForgotPasswordService { get }
    var email : String {get}
    init(service: ForgotPasswordService)
}

final class ForgotPasswordViewModelImpl: ObservableObject,ForgotPasswordViewModel {
    @Published var email: String = ""
    let service: ForgotPasswordService
    private var subscriptions = Set<AnyCancellable>()
    init(service: ForgotPasswordService) {
        self.service = service
    }
    
    func sendPaswwordReset() {
        service
            .sendPaswwordReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("Field:\(err)")
                default: break
                }
            } receiveValue: {
                print("Sent password Rest Request")
            }
            .store(in: &subscriptions)
        
        
    }
    
    
}

