//
//  UsersProfileView.swift
//  Briefull
//
//  Created by Amaal Almutairi on 21/07/1444 AH.
//

import SwiftUI

struct UsersProfileView: View {
    
    var user: User
    @EnvironmentObject var profileService : ProfileService
    @EnvironmentObject var session: SessionStore //current
    @State var profileImage: Image?

    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ScrollView{
            ProfileHeaderUsers(user: user, profileImage: profileImage)
                Divider()
            if let currentUserFriends = session.session?.friends {
                if (currentUserFriends.contains(user.uid)) {
                    VStack{
                        Text(" content will show")
                        //CONTENET
                    }
                }
            }
            
//
             
        }.navigationTitle(self.user.username)
            .onAppear{
                self.profileService.loadUserPosts(userId: self.user.uid)
            }
    }

}

//struct UsersProfileView_Previews: PreviewProvider {
//    @EnvironmentObject var profileService:ProfileService
//    static var previews: some View {
//        UsersProfileView(user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus")).environmentObject(ProfileService())
//    }
//}

/*
 var body: some View {
     ScrollView {
         
//            ProfileHeader(user: user, vlogsCounts:profileService.videos.count , friends:$profileService.friendsList)
//            Text(user.username)
//            ProfileHeader(user: user, vlogsCounts: profileService.videos.count, friends: $profileService.friendsList, request: $profileService.requestList)
         HStack{
             FollowButton(user: user, followCheck: $profileService.followCheck, requestCount: $profileService.requestList, friendstCount: $profileService.friendsList)
             
         }.padding(.horizontal)
     }.navigationTitle(self.user.username)
         .onAppear{
             self.profileService.loadUserVideos(userId: self.user.uid)
         }
 }
 */
