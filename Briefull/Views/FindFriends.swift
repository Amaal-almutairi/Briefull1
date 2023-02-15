//
//  FindFriends.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI


//struct FindFriends: View {
//
//    @EnvironmentObject var profileService:ProfileService
//    var user:User
//
//    var body: some View {
//        ScrollView{
//        VStack(alignment: .leading){
//
//                HStack{
//                    Text(" Friends Requestes")
//                    Text("\(profileService.following)").font(.headline).padding(.trailing, 50)
////                    Text("\(profileService.requestList)").font(.headline).padding(.trailing, 50)
//
//
////                    FollowButton(user: user, followCheck: $profileService.followCheck, requestCount: $profileService.requestList, friendstCount: $profileService.friendsList).foregroundColor(.white)
//
//                }.padding(.leading)
//                //            HStack{
//                //
//                //
//                //                ForEach(profileService.friendsList, id:\.uid) {
//                //                    user in
//                //                    Image(systemName: "person.circle")
//                //                        .resizable()
//                //                        .clipShape(Circle())
//                //                        .frame(width: 40, height: 40, alignment: .leading)
//                //                    Text(user.username)
//                //
//                //                }.padding(.leading, 50)
//                //            }
//                Divider()
//
//
//                HStack{
//                    Text("Your Friends")
//                    Text("\(profileService.followers)").font(.headline).padding(.trailing, 50)
////                    Text("\(profileService.friendsList)").font(.headline).padding(.trailing, 50)
//
//                    //                FollowButton(user: user, followCheck: $profileService.followCheck, requestCount: $profileService.requestList, friendstCount: $profileService.friendsList).foregroundColor(.white)
//
//                }.padding(.leading)
//
////            ForEach(profileService.users, id: \.uid) {
////                    user in
////                    HStack{
////                        Image(systemName: "person.circle")
////                            .resizable()
////                            .clipShape(Circle())
////                            .frame(width: 40, height: 40, alignment: .leading)
////                        Text(user.username)
////
////                    }.padding(.leading)
////                }
//            }
//        }
//        }
//    }

//
//struct FindFriends_Previews: PreviewProvider {
//    @EnvironmentObject var profileService:ProfileService
//
//    static var previews: some View {
//        FindFriends(user:  User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus")).environmentObject(ProfileService())
//    }
//}
