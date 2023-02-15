//
//  VedioService.swift
//  Briefull
//
//  Created by Amaal Almutairi on 18/07/1444 AH.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class VideoService{
    
    static var Videos = AuthService.storeRoot.collection("Vlogs")
    static var AllVideos = AuthService.storeRoot.collection("allVlogs")
    static var Timeline = AuthService.storeRoot.collection("timeline")
    
    static func VideosUserId(userId: String) -> DocumentReference {
        return Videos.document(userId)
    }
    
    static func timelineUserId(userld: String) -> DocumentReference {
        return Timeline.document(userld)
    }
    
    // this methode will upload the videos
    static func uploadVideo(caption: String, imageData: Data, onSuccess: @escaping()-> Void, onError: @escaping (_
                  errorMessage: String) -> Void) {
        guard let userld = Auth.auth().currentUser?.uid else {
            return
        }
        
        let videoId = VideoService.VideosUserId(userId: userld).collection("Vlogs").document().documentID
        let storageVideoRef = StorageService.storageVideoId(videoId: videoId)
        let metadata = StorageMetadata()
        metadata.contentType = ""
        StorageService.saveVideo(userId: userld, caption: caption, videoId: videoId, imageData: imageData, metaData: metadata, storageVideoRef: storageVideoRef, onSuccess: onSuccess, onError: onError)
    }
    
    // here it's method to fetch user's data
    static func loadUserVideo(userId: String, onSuccess: @escaping(_ video: [VideoModel]) -> Void) {
        VideosUserId(userId: userId).collection ("Vlogs").getDocuments{
            (snapshot, error) in
            guard let snap = snapshot else {
                print ("Error")
                return
            }
//            var vlogs = [VideoModel]()
            var posts = [VideoModel]()
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? VideoModel.init(fromDictionary: dict)
                else {
                    return
                }
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
}
