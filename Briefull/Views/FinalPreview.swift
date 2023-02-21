//
//  FinalPreview.swift
//  Briefull
//
//  Created by randa on 29/07/1444 AH.
//

import SwiftUI
import AVKit
import Firebase
import FirebaseStorage

struct FinalPreview: View {
    var url: URL
    var vidoe:VideoModel
    @State var isUploadded = false
    @State var caption = ""
    var videoId = VideoService.Videos.collectionID
    @EnvironmentObject var sessionStore : SessionStore
    //    var videoUrl: ""
    var body: some View{
        NavigationView{
            VStack{
                VideoPlayer(player: AVPlayer(url: url))
                    .aspectRatio(contentMode:.fill)
                    .frame (width: 350, height: 450)
                    .clipShape (RoundedRectangle (cornerRadius: 38, style: .continuous))
                
                                    NavigationLink {
                                        
                                        
//                                        StorageService.saveVideo(userId: sessionStore.session?.uid, caption: caption, videoId: videoId, imageData: imageData, metaData: metadata, storageVideoRef: storageVideoRef, onSuccess: onSuccess, onError: onError)
                
                                    } label: {
                
                                        Text("Publish")
                
                                            .padding(.horizontal, 20)
                                            .modifier(Items.ButtonModifier())
                                    }
                
//                Button {
//                
//                    uploadTOFireBaseVideo(url: url, caption: caption, userId: sessionStore.session?.uid ?? "No user id") { s in
//                        
//                        print("uploaded")
//                    } failure: { error in
//                        print("failed")
//                        return
//                        
//                    }
//                    uploadVideo()
//                    isUploadded = true
//
//                    
//                } label: {
//                    Text("Publish")
//                    
//                }
         
            }
        }
        .fullScreenCover(isPresented: $isUploadded, content: {
Timeline()
        })
    }
    
}


/*
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 guard let mediaInfo = info[.mediaType] else { return }
 let mediaType = "(mediaInfo)"
 if mediaType == "public.movie" {
 // how we handle it if it's a video
 guard let videoURL = info[.mediaURL] as? NSURL else {return }
 videoUrl = videoURL.filePathURL as? NSURL // this is the only thing I changed cause this is the file we are uploading
 }
 }
 */
// هذي الاسطر اتا غادة اللي سويت لها كومنت لان فيها ايرور ماقدرت ارفعه //
//func uploadVideo(){
//    let db = Firestore.firestore()
//    db.collection("Vlogs").getDocuments { snapshot, error in
//        if error == nil && snapshot != nil {
//            var paths = [String]()
//
//            for doc in snapshot! .documents {
//
//                paths.append(doc["url"] as! String)
//            }
//            for path in paths {
//                let storgeRef = Storage.storage().reference()
//                let fileRef = storgeRef.child(path)
//                fileRef.getData(maxSize: 5 * 1024) { data, error in
//                    if error == nil {
//                        guard  let videoUrl = info[.mediaUrl]
//                    }
//                }
//            }
//        }
//    }
//}
//
//func uploadTOFireBaseVideo(url: URL,caption: String,userId:String,
//                                  success : @escaping (String) -> Void,
//                                  failure : @escaping (Error) -> Void) {
//
//    guard let userld = Auth.auth().currentUser?.uid else {
//        return
//    }
//
//    let name = "\(Int(Date().timeIntervalSince1970)).mp4"
//    let path = NSTemporaryDirectory() + name
//
//    let dispatchgroup = DispatchGroup()
//
//    dispatchgroup.enter()
//
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let outputurl = documentsURL.appendingPathComponent(name)
//    var ur = outputurl
//   convertVideo(toMPEG4FormatForVideo: url as URL, outputURL: outputurl) { (session) in
//
//        ur = session.outputURL!
//        dispatchgroup.leave()
//
//    }
//    dispatchgroup.wait()
//
//    let data = NSData(contentsOf: ur as URL)
//
//    do {
//
//        try data?.write(to: URL(fileURLWithPath: path), options: .atomic)
//
//    } catch {
//
//        print(error)
//    }
//
//    let storageRef = Storage.storage().reference().child("Vlogs").child(name)
//    if let uploadData = data as Data? {
//
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//            storageRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
//        }
//    }
//}
//
//func convertVideo(toMPEG4FormatForVideo inputURL: URL, outputURL: URL, handler: @escaping (AVAssetExportSession) -> Void) {
//    do{
//        try? FileManager.default.removeItem(at: outputURL as URL)
//        let asset = AVURLAsset(url: inputURL as URL, options: nil)
//        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
//        exportSession.outputURL = outputURL
//        exportSession.outputFileType = .mp4
//        exportSession.exportAsynchronously(completionHandler: {
//            handler(exportSession)
//        })
//    }catch{
//        print(error.localizedDescription)
//    }
//
//
//
//}




