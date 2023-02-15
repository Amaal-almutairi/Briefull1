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
                  
                    
                    VStack(alignment: .leading){
                        Text("Sign Up").padding(.vertical).padding(.top,200).modifier(Items.TexStyleModifier()).padding(.bottom,100)
                        TextField("Enter userName", text: $userName).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        TextField("Enter Your Email Address", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding().keyboardType(.emailAddress)
                        SecureField("Enter Your PassWord", text: $passWord).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        SecureField("Re - Enter Your PassWord", text: $ConfermPassWord).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
//                        Button(action: { signUp()
//                            self.isLinkActive = true
//
//                        }){
//                            Text("Sign Up")
//                        }
//                        .modifier(Items.ButtonModifier()).alert(isPresented: $showingAlert){
//                            Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("OK")))
//                        }
//                            .navigationDestination(
//                                isPresented: $isLinkActive) {
//                                    Tab()
//
//                                }
                               
                        NavigationLink(destination: Tab(), isActive: $isLinkActive){

                            Button(action: { signUp()
                                self.isLinkActive = true

                            }){
                                Text("Sign Up")
                            }
                        } .modifier(Items.ButtonModifier()).alert(isPresented: $showingAlert){
                        Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("OK")))
                    }
////                        .navigationDestination(
////                            isPresented: $isLinkActive) {
////                             SignIn()
////
////                          }
////                            Text("").hidden()
//                        }
                     
//
//                        Button("Sign Up") {
//
//                            vm.signUp(email: email, password: passWord) { result in
//                                switch result {
//                                case .success(_):
//                                    coordinator.path.append(.login)
//                                case .failure(let error):
//                                    vm.errorMessage = error.errorMessage
//                                }
//                            }
//
//
//                        }.modifier(Items.ButtonModifier()).padding().foregroundColor(.white)
//                        if let errorMessage = vm.errorMessage {
//                            Text(errorMessage)
//                        }
                        HStack{
                            Spacer()
//                            NavigationLink(destination: SignIn()) {
//                              Text("Have an Account?")
//                            }
//                            Button("Have an Account?", action: {
//                                presentationMode.wrappedValue.dismiss()
//
//                            }).foregroundColor(Color("mauve"))
                          


                        }.padding()

                    }.padding(.bottom,400).padding(.trailing)
                }
                
            }
        }.padding(.leading)
        
        
//        .sheet(isPresented: $showLogInSheet){
//            SignIn()
//                .presentationDetents([.height(470)])
//                .presentationDragIndicator(.visible)
//        }
    }
    
//    func autheticateUser(email: String, password: String){
//
//        if email == email && password.lowercased() == passWord{
//
//
//        }else{
//            borderColor = Color.red
//        }
//    }
    
    
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
