//
//  ForgotPasswordView.swift
//  Briefull
//
//  Created by Ghada Amer Alshahrani on 23/07/1444 AH.
//

import SwiftUI

struct ForgetPasswordSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl(service: ForgotPasswordServiceEmpl())
    var body: some View {

            VStack(){
                Text("Find Your Breifull Account")
                    .font(.title)
                    .padding(.bottom,60)
                Image("f")
                    .resizable()
                    .frame(width: 230.0, height: 230.0)
                    .padding(.bottom, 50)
                Text("Enter your email and we'll send you a link to get back into your account. ")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    
                    
                
                TextField("email@ Example.com", text: $vm.email)
                    .modifier(Items.TextFieldStyleModifier())
                    .keyboardType(.emailAddress)
                    .padding()
                Button("Send Passowrd Reset") {
                    vm.sendPaswwordReset()
                    presentationMode.wrappedValue.dismiss()
                    
                }
                .modifier(Items.ButtonModifier())
                
            }
    }
}

struct ForgetPasswordSheet_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordSheet()
    }
}
