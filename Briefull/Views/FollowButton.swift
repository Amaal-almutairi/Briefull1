//
//  FollowButton.swift
//  Briefull
//
//  Created by Amaal Almutairi on 20/07/1444 AH.
//

import SwiftUI

struct FollowButton: View {
    @EnvironmentObject var followService:FollowService
    @EnvironmentObject var session: SessionStore //current

    var user:User
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @Binding var followCheck: Bool
    
    //    @Binding var friendstCount: Int
    //    @Binding  var requestCount:Int
    //    @Binding  var followCheck: Bool
    //
    init(user: User, followCheck: Binding<Bool>, followingCount:
         Binding<Int>, followersCount: Binding<Int> ){
        
        self.user = user
        self._followCheck = followCheck
        self._followingCount = followingCount
        self._followersCount = followersCount
        
        //        self.user = user
        //        self._followCheck = followCheck
        //        self._requestCount = requestCount
        //        self._friendstCount = friendstCount
        
    }
    
    func follow() {
        if !self.followCheck {
            followService.follow(userId: user.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            
            self.followCheck = true
            if var currentUser = session.session {
                currentUser.friends.append(user.uid)
            }
            
        }else{
            
            followService.unfollow(userId: user.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            self.followCheck = false
        }
    }
    
    
//    func follow() {
//        if !self.followCheck {
//            followService.follow(userId: user.uid, followingCount: {
//                 (followingCount) in
//            self.followingCount = followingCount
//
//            })
//            {
//             (followersCount) in
//           self.followersCount = followersCount
//            }
//            self.followCheck = true
//            if var currentUser = session.session {
//                currentUser.friends.append(user.uid)
//            }
//        }else {
//            followService.unfollow(userId: user.uid, followingCount: {
//                (followingCount) in
//                self.followingCount = followingCount
//            }) {
//                (followersCount) in
//                self.followersCount = followersCount
//            }
//                self.followCheck = false
//            }
//        }
    
    
    
    
    //    func follow(){
    //
    //        if !self.followCheck {
    //            // follow
    //            followService.requestFriends(userId: user.uid, requestCount: {
    //                (requestCount) in
    //                self.requestCount = requestCount
    //            }){
    //                (friendCount) in
    //                self.friendstCount = friendCount
    //            }
    //            self.followCheck = true
    //        }else {
    //            // unfollow
    //            followService.unAccaptFreindShip(userId: user.uid, requestCount: {
    //                (requestCount) in
    //                self.requestCount = requestCount
    //            }){
    //                (friendCount) in
    //                self.friendstCount = friendCount
    //            }
    //            self.followCheck = false
    //        }
    //    }
    
    var body: some View {
        Button(action: follow){
            Text((self.followCheck) ? "unfollow " : " follow ").foregroundColor(.white)
        }.background(.black).cornerRadius(20)
    }
}
//
//struct FollowButton_Previews: PreviewProvider {
//    @EnvironmentObject var followService:FollowService
//    static var previews: some View {
//        FollowButton(user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"), followCheck: .constant(true), followingCount: .constant(0), followersCount: .constant(0)).environmentObject(FollowService())
//    }
//}
