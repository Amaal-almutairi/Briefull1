//
//  ProfileHeader.swift
//  Briefull
//
//  Created by Amaal Almutairi on 20/07/1444 AH.
//

import SwiftUI
//import SDWebImageSwiftUI

struct ProfileHeader: View {
//    @State var userName = ""
//    @State var nickName = ""
     var user:User?
    var postsCounts:Int
    @Binding var following:Int
    @Binding var followers:Int
    
//    var userName:User
//    @Binding var friends:Int
//    @Binding var request:Int
//     var vlogsCounts:Int

    @EnvironmentObject var sessionVm: SessionStore
    @EnvironmentObject var followService:FollowService
    @EnvironmentObject var profileService:ProfileService

    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.circle")
                        .profileImageMod()
                    
                }.padding(.top,20)
//                Text(" nickName \(nickName)").font(.headline)
//                Text(sessionVm.session?.username ?? "UkUsername")
                Text(user?.username ?? "").font(.headline)
                HStack{
                    VStack{
                        Text(" Vlogs").padding(.leading, 50)
                        Text("  \(postsCounts)").font(.headline).padding(.leading, 50)
                    }
                    Spacer()
                    HStack{
                        VStack{
                            Text(" friends")
                            Text("  \(profileService.followers)").font(.headline)

//                            NavigationLink(destination: FindFriends(user:  User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))) {
//
//                            }
                        }.padding(.trailing,40)
//                        Spacer()
                        VStack{
                            Text(" request")
                            Text("  \(profileService.following)").font(.headline)

//                            NavigationLink(destination: FindFriends(user:  User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))) {
//
//                            }
                        }.padding(.trailing,40)
//                        Text("\(friends)").font(.headline).padding(.trailing, 50)
                    }
                    
                }.padding(.vertical,20)
//                HStack(alignment: .center){
//                    FollowButton(user: user ?? User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"), followCheck: $profileService.followCheck, followingCount: $profileService.following, followersCount: $profileService.followers).modifier(Items.ButtonModifierRequest())
//                }
//                Divider().fontWidth(.standard)
                Spacer().padding()
                
            }
        }
        
    }
}
//struct ProfileHeader_Previews: PreviewProvider {
//    @EnvironmentObject var sessionVm: SessionStore
//
//    static var previews: some View {
//
//        ProfileHeader(user: User?(User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus")), postsCounts: 0, following:.constant(0), followers:.constant(0))
//
////        ProfileHeader(user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"), vlogsCounts: .constant(0), friends:.constant(0))
//            .environmentObject(SessionStore())
//
//    }
//}

