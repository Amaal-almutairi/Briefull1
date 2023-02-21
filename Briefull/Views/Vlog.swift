import SwiftUI
import AVKit

struct Vlog: View {
    @StateObject var cameraModel = CameraViewModel()
    @State var showPreview = false
    @State var Delete = false
    var body: some View {
       // NavigationView {
            VStack{
                
                ZStack{
                    // camera view
                    CameraView()
                        .environmentObject (cameraModel)
                        .clipShape (RoundedRectangle (cornerRadius: 38, style: .continuous))
                        .frame(width: 350, height: 480)
                    
                    Button {
                        if cameraModel.isRecording{
                            cameraModel.stopRecording()
                        }
                        else{
                            cameraModel.startRecording()
                        }
                    } label: {
                        Circle()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Secondary"))
                            .opacity (cameraModel.isRecording ? 0 : 1)
                            .padding(8)
                            .frame(width: 70, height: 70)
                            .background{
                                Circle()
                                    .stroke(cameraModel.isRecording ? .red : .white, lineWidth: 4)
                            }
                    }.padding(.top, 370)
                }
                
                
                ScrollView (.horizontal, showsIndicators: true, content: {
                if  cameraModel.recordedURLs.count > 0{
                    HStack{
                        ForEach(cameraModel.recordedURLs, id: \.absoluteString){ r in
                            ZStack(alignment: .topTrailing){
                                VideoPlayer(player: AVPlayer(url: r))
                                    .aspectRatio(contentMode:.fill)
                                    .frame (width: 35, height: 64)
                                    .clipShape (RoundedRectangle (cornerRadius: 6, style: .continuous))
                                // ZStack(alignment: .topLeading){
//                                    .overlay (content: {
//                                        if let url = cameraModel.previewURL,cameraModel.showPreview{
//                                            FinalPreview1(url: url)
//                                            .transition(.move(edge:.trailing)) } })
//
//                                    .animation (.easeInOut, value: cameraModel.showPreview)
                                
//                                
//                                Button{
//                                    Delete.toggle()
//                                    let myInt =  Int( r.absoluteString) ?? 0
//                                    deleteVideo(indexSet:myInt)
//                                } label:{
//                                    Image(systemName: "xmark.circle.fill")
//                                        .font(.system(size: 13))
//                                        .foregroundColor(Color("Black"))
//                                    
//                                    // }
//                                    
//                                }
                                //.frame(alignment: .topLeading)
                                
                            }
                            
                        }
                    }
                        
//                    }  .overlay (content: {
//                        if let url = cameraModel.previewURL,cameraModel.showPreview{
//                            FinalPreview1(url: url)
//                                .transition(.move(edge:.trailing)) } })
//
//    .animation (.easeInOut, value: cameraModel.showPreview)
    
                }
                })
                
                
                // Preview Button
                NavigationLink {
                    if let url = cameraModel.previewURL {
                        FinalPreview(url: url, vidoe: VideoModel(caption: "", likes: [:], geoLocation: "", ownerld: "", videoId: "", username: "", profile: "", mediaUrl: "", date: 0.0, likeCount: 0))
                    }
                    
                } label: {
                    
                    Text("Next")
                    
                        .padding(.horizontal, 20)
                        .modifier(Items.ButtonModifier())
                }
            }
       // }
        //.navigationViewStyle(.stack)
        
        //                Button {
        ////                    if let url = cameraModel.previewURL{
        ////                        FinalPreview(url: url)
        ////                            .transition(.move(edge:.trailing))
        ////                    }
        //                    showPreview.toggle()
        //                } label: {
        //                    Text("Next")
        //                }
        //                .padding(.horizontal, 20)
        //                .modifier(Items.ButtonModifier())
        //            }.fullScreenCover(isPresented: $showPreview ){
        //                //FinalPreview(url: url)
        //                FinalPreview()
        //            }
        
    }
    

    func deleteVideo(indexSet: Int) {
        //  withAnimation {
        //               guard let index = indexSet.first else {return}
        
        cameraModel.recordedURLs.remove(at: indexSet)

        let assets = cameraModel.recordedURLs.compactMap { url -> AVURLAsset in
            return AVURLAsset(url: url)
        }
        
        // MERGING VIDEOS
        cameraModel.mergeVideos(assets: assets){ exporter in
            exporter.exportAsynchronously {
                if exporter.status == .failed{
                   
                    // HANDLE ERROR
                    print (exporter.error!)
                }
                else{
                    if let finalURL = exporter.outputURL {
                        print(finalURL)
                        
                        DispatchQueue.main.async{
                            cameraModel.previewURL = finalURL
                        }
                    }
                }
            }
        }
    
        
        // }
    }
}
//    func PrevModel(){
//
//    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Vlog()
    }
}


// MARK: Final Video Preview
//struct FinalPreview: View{
//    var url: URL
////@Binding var showPreview: Bool
//    var body: some View{
//
//        VideoPlayer(player: AVPlayer(url: url))
//                .aspectRatio(contentMode:.fill)
//                .frame (width: 350, height: 450)
//                .clipShape (RoundedRectangle (cornerRadius: 38, style: .continuous))
//            // MARK: Back Button
////                .overlay (alignment: .topLeading) {
////                    Button {
////                        showPreview.toggle()
////                    } label: {
////                        Label {
////                            Text("Back")
////                        } icon: {
////                            Image(systemName: "chevron.left")
////                        }
////                        .foregroundColor (.white)
//                   // }
//        //}
//    }
//}




//NavigationLink {
//                PhotoCollectionView(photoCollection: model.photoCollection)
//                    .onAppear {
//                        model.camera.isPreviewPaused = true
//                    }
//                    .onDisappear {
//                        model.camera.isPreviewPaused = false



struct FinalPreview1: View {

    
      var url: URL
        var body: some View{
          //  NavigationView{
                VStack{
                    VideoPlayer(player: AVPlayer(url: url))
                        .aspectRatio(contentMode:.fill)
                        .frame (width: 350, height: 450)
                        .clipShape (RoundedRectangle (cornerRadius: 38, style: .continuous))
                      
                    //   MARK: Back Button
                        .overlay (alignment: .topLeading) {
                            Button {
                               // showPreview.toggle()
                            } label: {
                                Label {
                                    Text("Back")
                                } icon: {
                                    Image(systemName: "chevron.left")
                                }
                                .foregroundColor (.white)
                            }
               
                    }
                }
            }
//            Text("Hello")
        }
   // }


