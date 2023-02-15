//
//  HomeView.swift
//  Briefull
//
//  Created by Amaal Almutairi on 17/07/1444 AH.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
//    var user:User
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileService:ProfileService
    
    func listen(){
        session.listen()
    }
    var body: some View {
        
        // if there is user will return Tab view  , if there is no user will return sign in
        Group{
            if (session.session != nil){
             Tab()
            }else{
                SignIn()
            }
        }.onAppear(perform: listen)
     
 
// && user.username == profileService.friendsList
            
    }
}

//struct HomeView_Previews: PreviewProvider {
//    var session:SessionStore
//
//    static var previews: some View {
//        HomeView().environmentObject(SessionStore())
//    }
//}
