//
//  Home.swift
//  Briefull
//
//  Created by randa on 29/07/1444 AH.
//


import SwiftUI
import AVKit

struct Home: View {
    @StateObject var cameraModel = CameraViewModel()
    @State var showPreview = false
    @State var Delete = false
    var body: some View {
        NavigationView {
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
                
                
                
                if  cameraModel.recordedURLs.count > 0{
                    HStack{
                        ForEach(cameraModel.recordedURLs, id: \.absoluteString){ r in
                            ZStack(alignment: .topTrailing){
                                VideoPlayer(player: AVPlayer(url: r))
                                    .aspectRatio(contentMode:.fill)
                                    .frame (width: 35, height: 64)
                                    .clipShape (RoundedRectangle (cornerRadius: 6, style: .continuous))
            
                                    
                                    Button{
                                        Delete.toggle()
                                        let myInt =  Int( r.absoluteString) ?? 0
                                        deleteVideo(indexSet:myInt)
                                    } label:{
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 13))
                               }
                                
                            }
                        }
                        
                    }
                }
                
                
                // Preview Button
                NavigationLink {
                    if let url = cameraModel.previewURL {
                        FinalPreview(url: url)
                    }
                    
                } label: {
                    
                    Text("Next")
                    
                        .padding(.horizontal, 20)
                        .modifier(Items.ButtonModifier())
                }
            }
        }
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
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
