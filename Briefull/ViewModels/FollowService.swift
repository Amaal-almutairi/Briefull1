//
//  FollowService.swift
//  Briefull
//
//  Created by Amaal Almutairi on 20/07/1444 AH.
//

import Foundation
import Firebase


class FollowService: ObservableObject {
    
    func updateFollowCount(userId: String, followingCount: @escaping(_ followingCount: Int)-> Void, followersCount: @escaping(_ followersCount: Int)-> Void) {
        
        ProfileService.followingCollection(userid: userId).getDocuments{
            (snap, error) in
            
            if let doc = snap?.documents{
                followingCount(doc.count)
            }
        }
        ProfileService.followersCollection(userid: userId).getDocuments{
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
    }
    
    // it will check weather or not followcheck is true or false
    func manageFollow(userId: String, followCheck: Bool, followingCount: @escaping(_ followingCount: Int)-> Void, followersCount: @escaping(_ followersCount: Int)-> Void) {
        
        if !followCheck {
            follow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        } else {
            unfollow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        }
    }
    
    func follow(userId: String, followingCount: @escaping(_ followingCount: Int)-> Void, followersCount: @escaping(_ followersCount: Int)-> Void) {
        ProfileService.followingId(userId: userId).setData([:]){
            (err) in
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        ProfileService.followersId(userld: userId).setData([:]){
            (err) in
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
                
            }
            
        }
    }
    
    func unfollow(userId: String, followingCount: @escaping(_ followingCount: Int)-> Void, followersCount: @escaping(_ followersCount: Int)-> Void) {
        
        ProfileService.followingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                // after we delete users we update followers
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
                ProfileService.followersId(userld: userId).getDocument {
                    (document, err) in
                    if let doc = document, doc.exists {
                        doc.reference.delete()
                        self.updateFollowCount(userId: userId, followingCount:followingCount, followersCount: followersCount)
                    }
                }
            }
        }
   /*
     class FollowService: ObservableObject {
     
     func updateRequestCount(userId: String, requestCount: @escaping (_ requestCount:Int) -> Void, friendstCount: @escaping (_ friendstCount:Int)-> Void){
     ProfileService.requestCollection(userid: userId).getDocuments {
     (snap, error) in
     
     if let doc = snap?.documents {
     requestCount(doc.count)
     }
     }
     
     
     ProfileService.friendsCollection(userid: userId).getDocuments {
     (snap, error) in
     
     if let doc = snap?.documents {
     friendstCount(doc.count)
     }
     }
     
     
     }
     
     
     // it will check if usser follow or not
     func manageFollow(userId: String,  followCheck: Bool ,requestCount: @escaping (_ requestCount:Int) -> Void, friendstCount: @escaping (_ friendstCount:Int)-> Void){
     
     if !followCheck {
     requestFriends(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     
     }else{
     unAccaptFreindShip(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     
     }
     }
     
     // unfollow friends
     func unAccaptFreindShip(userId: String, requestCount: @escaping (_ requestCount:Int) -> Void, friendstCount: @escaping (_ friendstCount:Int)-> Void) {
     
     ProfileService.requestId(userId: userId).setData([:]){
     (error) in
     if error == nil {
     self.updateRequestCount(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     }
     }
     
     ProfileService.friendsId(userId: userId).setData([:]){
     (error) in
     if error == nil {
     self.updateRequestCount(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     }
     }
     
     }
     
     // follow friends
     func requestFriends(userId: String, requestCount: @escaping (_ requestCount:Int) -> Void, friendstCount: @escaping (_ requestCount:Int)-> Void) {
     
     ProfileService.requestId(userId: userId).getDocument {
     (document, error) in
     
     if let doc = document, doc.exists {
     doc.reference.delete()
     
     self.updateRequestCount(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     }
     }
     
     ProfileService.friendsId(userId: userId).getDocument {
     (document, error) in
     
     if let doc = document, doc.exists {
     doc.reference.delete()
     
     self.updateRequestCount(userId: userId, requestCount: requestCount, friendstCount: friendstCount)
     }
     }
     
     }
     
     
     }
     */
