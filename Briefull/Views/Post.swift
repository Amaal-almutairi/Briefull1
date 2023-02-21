//
//  Post.swift
//  Briefull
//
//  Created by Amaal Almutairi on 01/08/1444 AH.
//

import SwiftUI

struct Post: View {
    
    @State var showLogInSheet = false
    @Environment(\.presentationMode) var presentationMode
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No"
    @State private var videoData:Data = Data()
    @State var videoSelected: Image?
    @State var videoeImg: Image?
    @State var showActionSheetVideo = false
    @State var showvideoePikerProfile = false
    @State var sourceType:UIImagePickerController.SourceType = .photoLibrary
    @State var text = ""
    @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

    
    
    func loadImage() {
        
        guard let inputVideo = videoSelected else { return}
        videoeImg = inputVideo
    }
    
    func clear(){
        self.text = ""
        self.videoData = Data()
        self.videoeImg = Image(systemName: "play")
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            videoData.isEmpty {
            return "Please add a caption and provide an video"
        }
        return nil
        
    }
    
    func uploadVideo() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        self.clear()
        
        VideoService.uploadVideo(caption: text, imageData: videoData, onSuccess: {
            self.clear()
        }) { (errorMessage) in
             self.showingAlert = true
            return
        }
    }
    
    
    var body: some View {
        VStack{
            VStack{
                if videoeImg != nil {
                    if let  videoeImg = videoeImg {
                        videoeImg.resizable().frame(width: 300, height: 200)
                            .onTapGesture {
                                self.showActionSheetVideo = true
                            }
                    }
                }else {
                    Image(systemName: "play").resizable().frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showActionSheetVideo = true
                        }
                }
            }
            TextEditor(text: $text)
                .frame(height: 200).padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
            
            Button(action: uploadVideo) {
                Text("Upload Video").font(.title).modifier(Items.ButtonModifier())
            }.alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle),message: Text(error),dismissButton: .default(Text("OK")))
            }
            
        }.navigationTitle("Upload a video")
        .padding(.trailing,20).padding(.leading)

        .sheet(isPresented: $showvideoePikerProfile, onDismiss: loadImage) {
            ImagePicker(selectedImage: self.$videoSelected, showImagePiker: self.$showvideoePikerProfile, imageData: self.$videoData)
        }.actionSheet(isPresented: $showActionSheetVideo){
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Choose A Photo")){
                    self.sourceType = .photoLibrary
                    self.showvideoePikerProfile = true
                }, .cancel()
            ])
        }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
