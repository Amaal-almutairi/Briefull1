//
//  Profile.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI
import FirebaseAuth
//import Firebase

struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileService: ProfileService
//    var user:User
    //
    //    func listen(){
    //        session.listen()
    //    }
    
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeader(user: self.session.session, postsCounts:
                                profileService.posts.count, following:
                                $profileService.following, followers:
                                $profileService.followers)
            }
            .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action:{}){
                    NavigationLink(destination: EditPersonalInfo()){
                       Text("edit")
                    }
                    
                }).accentColor(.black)
//                .navigationBarItems(leading: Button(action:{}){
//                    NavigationLink(destination: FindFriends(user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))){
//                        HStack{
//                            Text("request")
////                            FollowButton(user: user, followCheck: $profileService.followCheck, requestCount: $profileService.requestList, friendstCount: $profileService.friendsList).foregroundColor(.white)
////                            Text("\(profileService.followers)").font(.headline).padding(.trailing, 50)
//
//                        }
//                    }
//
//                }).accentColor(.black)
        }
        
    }
}
struct Profile_Previews: PreviewProvider {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileService:ProfileService
    static var previews: some View {
        Profile()
//        Profile( user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))
            .environmentObject(ProfileService()).environmentObject(SessionStore())
    }
}

/*
 VStack{
     ProfileHeader(user: self.session.session, vlogsCounts: profileService.videos.count, friends: $profileService.friendsList, request: $profileService.requestList)
     //                ProfileHeader(user: self.session.session, vlogsCounts: profileService.videos.count , friends:$profileService.friendsList)
     
     // .navigationViewStyle(.stack)
 }
 */
