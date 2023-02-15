//
//  SignIn.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

struct SignIn: View {
    @State var email = ""
    @State var passWord = ""
    @StateObject private var vm = SignUpViewModel()
    @State var showVlogSheet = false
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No"
    @EnvironmentObject var session: SessionStore
    
    
    func listen(){
        session.listen()
    }
    
    
    func errorCheck() -> String? {
        if email.trimmingCharacters (in: .whitespaces).isEmpty ||
            passWord.trimmingCharacters (in: .whitespaces).isEmpty {
            return "Please Fill in all fields"
        }
        return nil
        
    }
    func clear(){
        self.email = ""
        self.passWord = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
      
        AuthService.signIn(email: email, password: passWord, onSuccess:{
            (user) in
            self.clear()
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
                        Text("Sign In").padding(.top,200).modifier(Items.TexStyleModifier()).padding(.bottom,100)
                        
                        TextField("Enter Your Email Address", text: $email).padding()
                            //.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        SecureField(" Enter Your PassWord", text: $passWord).padding()
                            //.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        Button(action: { signIn()
                        listen()
                    }){
                        Text("Sign In")
                    }.modifier(Items.ButtonModifier()).padding().alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("OK")))
                        }
                        
//                        if let errorMessage = vm.errorMessage {
//                            Text(errorMessage)
//                        }
                        HStack{
                            Button {
                              
                            } label: {
                                Text("Forget Password")
                            }
                            Spacer()
                            NavigationLink(destination: SignUp()) {
                                Text("Create New Account?").foregroundColor((Color("mauve")))
                            }


                        }.padding().accentColor(Color("mauve"))

                    }.padding().padding(.bottom,400)
                }
                
            }.navigationBarBackButtonHidden(true)
        }.fullScreenCover(isPresented: $showVlogSheet) {
           Tab()
        }
    }
    
}

struct SignIn_Previews: PreviewProvider {
    var vm = SignUpViewModel()
    var session:SessionStore
    static var previews: some View {
        SignIn().environmentObject(SignUpViewModel()).environmentObject(SessionStore())
    }
}
