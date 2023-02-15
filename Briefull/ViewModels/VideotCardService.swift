//
//  VideoCardService.swift
//  Briefull
//
//  Created by Amaal Almutairi on 18/07/1444 AH.
//


import SwiftUI
import Firebase

class VideotCardService: ObservableObject {
    
    @Published var post: VideoModel!
    @Published var isLiked = false
    
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true)
        ? true: false
    }
    func like() {
        post.likeCount += 1
        isLiked = true
        VideoService.VideosUserId(userId: post.ownerld).collection("posts").document(post.videoId)
            .updateData(["likeCount": post.likeCount,
                     "\(Auth.auth().currentUser!.uid)": true])
        VideoService.AllVideos.document(post.videoId).updateData(
            ["likeCount": post.likeCount,
             "\(Auth.auth().currentUser!.uid)": true])
        VideoService.timelineUserId(userld:post.ownerld).collection("timeline").document(post.videoId)
            .updateData(["likeCount": post.likeCount,"\(Auth.auth().currentUser!.uid)": true])
}
}
