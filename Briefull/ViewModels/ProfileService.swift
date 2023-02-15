//
//  ProfileService.swift
//  Briefull
//
//  Created by Amaal Almutairi on 19/07/1444 AH.
//

import Foundation
import Firebase


class ProfileService: ObservableObject {
    
    @Published var posts: [VideoModel] = []
    @Published var following = 0
    @Published var followers = 0
    @Published var followCheck = false
    @Published var users: [User] = []
    
    static var following = AuthService.storeRoot.collection("following")
    static var followers = AuthService.storeRoot.collection("followers")
    
    static func followingCollection(userid: String) -> CollectionReference{
        return following.document(userid).collection("following")
    }
    static func followersCollection(userid: String) -> CollectionReference{
        return followers.document(userid).collection("followers")
        func loadUserPosts(userId: String ){
            VideoService.loadUserVideo(userId: userId) {
                (posts ) in
            }
        }
    }
    static func followingId(userId: String) -> DocumentReference {
        
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
        
    }
    
    
    static func followersId(userld: String) -> DocumentReference {
        return followers.document(userld).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    // if we check inside following  we find user id that means wer'e following
    func followState(userid: String) {
        ProfileService.followingId(userId: userid).getDocument{
            (document, error) in
            if let doc = document, doc.exists {
                self.followCheck = true
            } else {
                // if we don't have the following id that means weren't folloing that uers
                self.followCheck = false
            }
        }
    }
    //
    func loadUserPosts(userId: String ){
        VideoService.loadUserVideo(userId: userId) {
            (posts) in
            self.posts = posts
        }
        follows(userId: userId)
        followers(userId: userId)
    }
    
    func follows(userId: String) {
        ProfileService.followingCollection(userid: userId).getDocuments {
            (querysnapshot, err) in
            if let doc = querysnapshot?.documents {
                self.following = doc.count
//                print(self.users)
            }
        }
    }
    func followers(userId: String){
        ProfileService.followersCollection(userid: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.followers = doc.count
                
            }
        }
    }
}
/*
class ProfileService: ObservableObject {
    
    @Published var videos: [VideoModel] = []
    @Published var friendsList = 0
    @Published var requestList = 0
    @Published var followCheck = false
    @Published var users: [User] = []
    
    static var request = AuthService.storeRoot.collection("request")
    static var friends = AuthService.storeRoot.collection("friends")
    
        
    // following
    static func requestCollection(userid: String) -> CollectionReference{
        return request.document(userid).collection("request")
            }
    // followers
    static func friendsCollection(userid: String) -> CollectionReference{
        return friends.document(userid).collection("friends")
            }
    
    
    // request
    static func requestId(userId: String) -> DocumentReference {
        return request.document(Auth.auth().currentUser?.uid ?? "no request").collection("request").document(userId)
    }
    
    //friends
    static func friendsId(userId: String) -> DocumentReference{
        return friends.document(userId).collection("friends").document(Auth.auth().currentUser?.uid ?? "no friends")
    }
    
    func friendState(userId: String){
        ProfileService.requestId(userId: userId).getDocument {
            
            (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
            }else{
                self.followCheck = false
            }
        }
    }

    func loadUserVideos(userId: String) {
        VideoService.loadUserVideo(userId: userId) {
            (video) in
            self.videos = video
            
        }
        friendsInfo(userId: userId)
        requestFriendship(userId: userId)
    }
    
 
    func requestFriendship(userId: String) {
        ProfileService.requestCollection(userid: userId).getDocuments {
            (querysnapshot, err) in
            if let doc = querysnapshot?.documents {
                self.requestList = doc.count
            }
        }
    }
    
    
    func friendsInfo(userId:String){
        ProfileService.friendsCollection(userid: userId).getDocuments {
            (querysnapshot, err) in
            if let doc = querysnapshot?.documents {
                self.friendsList  = doc.count
            }
        }
    }
    
    
    
}
*/
