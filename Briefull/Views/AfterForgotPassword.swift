//
//  AfterForgotPassword.swift
//  Briefull
//
//  Created by Ghada Amer Alshahrani on 23/07/1444 AH.
//

import SwiftUI

struct AfterForgotPassword: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack{
                
                Image("Email")
                    .padding(.bottom, 20.0)
                Text("Password Reset Link Sent")
                    .font(.title)
                    .padding(.bottom, 10.0)
                Text("Please Check your email to Change your Password ")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding()

            Button("Ok") {
                dismiss()
            }
            .font(.headline)
           // .frame(maxWidth: .infinity)
            .frame(width:360,height: 44)
            .background(Color("mauve"))
            .foregroundColor(.white)
            .cornerRadius(12)
    
            .padding(.top, 50.0)
            
                
        }
    }
}

struct AfterForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        AfterForgotPassword()
    }
}
