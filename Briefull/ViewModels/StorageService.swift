//
//  StorageService.swift
//  Briefull
//
//  Created by Amaal Almutairi on 16/07/1444 AH.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class StorageService{
    
    static var storage = Storage.storage()
    static var storageRoot = storage.reference()
    static var storageProfile = storageRoot.child("profile")
    static var storageVideo = storageRoot.child("Vlogs")
    
    
    static func storageVideoId(videoId:String) -> StorageReference {
        return storageVideo.child(videoId)
    }
    
    static func storageProfileId(userId:String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    static func saveProfileImage(userId:String, username:String, email:String, imageData: Data,
                                 metaData:StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) ->
                                 Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        storageProfileImageRef.putData(imageData,metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError (error!.localizedDescription)
                return
            }
            storageProfileImageRef.downloadURL{
                (url, error) in
                if let metaImageUr1 = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error?.localizedDescription ?? "unKnown")
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    let user = User.init(uid: userId, email: email, profileImageUr1: metaImageUr1, username: username, searchName: username.splitString(), caption: "")
                    
                    guard let dict = try?user.asDictionary() else {return}
                    firestoreUserId.setData(dict) { (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                        
                    }
                    onSuccess(user)
                }
                
            }
            
        }
    }
    
    static func saveVideo(userId:String, caption:String, videoId:String, imageData:Data, metaData:StorageMetadata, storageVideoRef: StorageReference, onSuccess: @escaping() -> Void ,onError: @escaping(_ errorMessage: String) -> Void){
        storageVideoRef.putData(imageData,metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageVideoRef.putData(imageData, metadata: metaData) {
                (StorageMetadata, error) in
                if error != nil {
                    onError (error!.localizedDescription)
                    return
                }
                
                storageVideoRef.downloadURL{
                    (url, error) in
                    if let metaVideoUr1 = url?.absoluteString {
                        let firestoreVideoRef = VideoService.VideosUserId(userId:userId).collection("Vlogs").document(videoId)
                        
                        let video = VideoModel.init(caption: caption, likes: [:], geoLocation: "", ownerld: userId, videoId: videoId, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth () .currentUser! .photoURL!.absoluteString, mediaUrl: metaVideoUr1, date: Date().timeIntervalSince1970, likeCount: 0)
                        
                        guard let dict = try? video.asDictionary() else{return}
                        
                        firestoreVideoRef.setData(dict) {
                            (error) in
                            
                            if error != nil {
                                onError (error!.localizedDescription)
                                return
                            }
                            /*
                             VideoService.timelineUserId(userld:userId).collection("timeline").document(videoId).setData(dict)
                             VideoService.AllVideos.document(videoId).setData(dict)
                             onSuccess
                             */
                            VideoService.timelineUserId(userld: userId).collection("timeline").document(videoId).setData(dict)
                            VideoService.AllVideos.document(videoId).setData(dict)
                        }
                        onSuccess()

                    }
                    
                }
            }
            
        }
        
    }
}



        
   // }
    
    
//}
        
//        storageVideoRef.putData(imageData,metadata:metaData){
//            (StorageMetadata, error) in
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//            storageVideoRef.putData(imageData,metadata: metaData){(StorageMetadata, error) in
//                if error != nil {
//                    onError(error!.localizedDescription)
//                    return
//                }
//            }
//                storageVideoRef.downloadURL{
//                    (url, error) in
//                    if let metaImageUr1 = url?.absoluteString {
//                        let firestoreVideoRef = VideoService.VideosUserId(userId:videoId).collection("Vlogs").document(videoId)
//                    }
//
//            }
//
     


/*
 static func saveProfileImage(userId:String, username:String, email:String, imageData: Data,
                               metaData:StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) ->
                               Void, onError: @escaping(_ errorMessage: String) -> Void ) {
     storageProfileImageRef.putData(imageData,metadata: metaData) {
         (StorageMetadata, error) in
         if error != nil {
             onError (error!.localizedDescription)
             return
         }
         storageProfileImageRef.downloadURL{
             (url, error) in
             if let metaImageUr1 = url?.absoluteString {
                 
                 if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                     changeRequest.photoURL = url
                     changeRequest.displayName = username
                     changeRequest.commitChanges{
                         (error) in
                         if error != nil {
                             onError(error?.localizedDescription ?? "unKnown")
                             return
                         }
                     }
                 }
                 
                 let firestoreUserId = AuthService.getUserId(userId: userId)
                 let user = User.init(uid: userId, email: email, profileImageUr1: metaImageUr1, username: username, searchName: username.splitString(), caption: "")
                 
                 guard let dict = try?user.asDictionary() else {return}
                 firestoreUserId.setData(dict) { (error) in
                     if error != nil {
                         onError(error!.localizedDescription)
                     }
                     
                 }
                 onSuccess(user)
             }
             
         }
         
     }
 }
 */


/*
 storageVideoRef.downloadURL{
 (url, error) in
     if let metaVideoUr1 = url?.absoluteString {
     let firestoreVideoRef = VideoService.VideosUserId(userId:videoId).collection("Vlogs").document(videoId)
     
     let video = VideoModel.init(caption: caption, likes: [:], geoLocation: String, ownerld: videoId, postId: videoId, username: Auth.auth().currentUser ?? "ukUser".displayName, profile: Auth.auth().currentUser ?? "".video.absoluteString, mediaUrl: metaVideoUr1, date: Date().timeIntervalSince1970, likeCount: 0)
     
     guard let dict = try? video.asDictionary() else{return}
     
     firestoreVideoRef.setData(dict) {
         (error) in
         
         if error != nil {
             onError (error!.localizedDescription)
             return
         }
         VideoService.timelineUserId(userld: videoId).collection("timeline").document(videoId).setData(dict)
         VideoService.AllVideos.document(videoId).setData(dict)
         onSuccess
         
     }
     
 }
}
 */

/*
 storageVideoRef.downloadURL{
     (url, error) in
     
     if let metaVideoUr1 = url?.absoluteString {
     let firestoreVideoRef = VideoService.VideosUserId(userId:userId).collection("Vlogs").document(videoId)
     
         let video = VideoModel.init(caption: caption, likes: [:], geoLocation: "", ownerld: userId, postId: videoId, username: Auth.auth().currentUser!.photoURL!.absoluteString,profile: Auth.auth().currentUser ?? "".video.absoluteString, mediaUrl: metaVideoUr1, date: Date().timeIntervalSince1970, likeCount: 0)
     
     guard let dict = try? video.asDictionary() else{return}
     
     firestoreVideoRef.setData(dict) {
         (error) in
         
         if error != nil {
             onError (error!.localizedDescription)
             return
         }
         VideoService.timelineUserId(userld: videoId).collection("timeline").document(videoId).setData(dict)
         VideoService.AllVideos.document(videoId).setData(dict)
         onSuccess
         
     }
     
 }
}
 */
