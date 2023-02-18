//
//  SignUp.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

struct SignUp: View {
    
    @State var email = ""
    @State var passWord = ""
    @State var ConfermPassWord = ""
    @State var userName = ""
    @State private var borderColor = Color.clear
    @StateObject private var vm = SignUpViewModel()
    //    @EnvironmentObject var coordinator: Coordinator
    @State var showLogInSheet = false
    @Environment(\.presentationMode) var presentationMode
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No"
    @State private var videoData = Data()
    @State private var isLinkActive = false
    
    func errorCheck() -> String? {
        if email.trimmingCharacters (in: .whitespaces).isEmpty ||
            passWord.trimmingCharacters (in: .whitespaces).isEmpty ||
            
            userName.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please Fill in all fields"
        }
        return nil
        
    }
    func clear(){
        self.email = ""
        self.userName = ""
        self.passWord = ""
        self.ConfermPassWord = ""
        self.videoData = Data()
        
    }
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        
        AuthService.signUp(username: userName, email: email, password: passWord, imageData:videoData, onSuccess:{
            (user) in self.clear()
        }){ errorMessage in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        VStack{
            
            ScrollView {
                ZStack(alignment: .center){
                    
                    
                    VStack(){
                        Text("Create Account").padding(.vertical).padding(.top,200).modifier(Items.TexStyleModifier()).padding(.bottom,100)
                        
                        Text("UserName")
                            .modifier(Items.TextModifier())
                        
                        TextField("@Ghada12", text: $userName)
                            .modifier(Items.TextFieldStyleModifier())
                        
                        
                        Text("Email")
                            .modifier(Items.TextModifier())
                        
                        TextField("email@ Example.com", text: $email).modifier(Items.TextFieldStyleModifier()).keyboardType(.emailAddress)
                        VStack(){
                            Text("Password")
                                .modifier(Items.TextModifier())
                            SecureField("**************", text: $passWord).modifier(Items.TextFieldStyleModifier())
                            
                            Text("Confirm Password")
                                .modifier(Items.TextModifier())
                            
                            SecureField("**************", text: $ConfermPassWord).modifier(Items.TextFieldStyleModifier())
                        }
                        
                        NavigationLink(destination: Tab(), isActive: $isLinkActive){
                            
                            Button(action: { signUp()
                                self.isLinkActive = true
                                
                            }){
                                Text("Sign Up")
                            }
                        } .modifier(Items.ButtonModifier()).alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("OK")))
                        }
                        .padding()
                        
                        
                        HStack{
                            Spacer()
                            Button("Have an Account? Sign in ", action: {
                                SignIn()
                                presentationMode.wrappedValue.dismiss()
                                
                            }).foregroundColor(Color("Black"))
                                .font(.caption)
                                .padding(.horizontal, 56)
                                .padding(.top)
                            
                        }
                        
                    }.padding()
                }
                
            }
        }
        
        
    }
}



// Create Sign up page

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
        //        NavigationStack {
        //            SignUp()
        //        }.navigationDestination(for: Route.self) { route in
        //            switch route {
        //            case .SessionStore:
        //                Text("SessionStore")
        //
        //            }
        //        }
    }
}
