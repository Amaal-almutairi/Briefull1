//
//  CameraView1.swift
//  Briefull
//
//  Created by randa on 29/07/1444 AH.
//

import SwiftUI
import AVFoundation

// take from preveiosly project
struct CameraView: View {
    @EnvironmentObject var cameraModel: CameraViewModel
    var body: some View{
     
        GeometryReader{proxy in
            let size = proxy.size
            
            CameraPreview(size: size)
                .environmentObject (cameraModel)
           
            //DELETE FROM THIS PART
            ZStack(alignment: .topLeading){
//                Rectangle ()
//                    .fill(.black.opacity (0.25))
                Rectangle ()
                    .fill(Color.red)
                    . frame (width: size.width * (cameraModel.recordedDuration / cameraModel.maxDuration) )
//                    .frame(maxHeight: .infinity, alignment:.bottomLeading)
                    .frame(height: 8)
                
            }.padding(.leading, 20)
                //UNTIL HERE
            
            
            
            
            
        }//Adds an action to perform before this view appears.
            .onAppear (perform: cameraModel.checkPermission)
            .alert (isPresented: $cameraModel.alert) {
            Alert(title: Text("Please Enable cameraModel Access Or Microphone Access!!!"))
                        
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()){ _ in
                if cameraModel.recordedDuration <= cameraModel.maxDuration && cameraModel.isRecording{
                    cameraModel.recordedDuration += 0.01
                }
                if cameraModel.recordedDuration >= cameraModel.maxDuration && cameraModel.isRecording{
                    // Stopping the Recording
                    cameraModel.stopRecording ( )
                    cameraModel.isRecording = false
                }
            }
        }
    }

//UIViewRepresentable to integrate that view into your SwiftUI view hierarchy.

struct CameraPreview: UIViewRepresentable {
    
    @EnvironmentObject var cameraModel : CameraViewModel
    var size : CGSize
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame.size = size
        
       
        cameraModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraModel.preview)
        
 
        cameraModel.session.startRunning()
        
        return view
    }
    func updateUIView(_ uiview: UIView, context: Context) {
    }
}

