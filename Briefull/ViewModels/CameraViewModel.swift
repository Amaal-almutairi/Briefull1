//
//  CameraViewModel.swift
//  Briefull
//
//  Created by randa on 26/07/1444 AH.
//

import SwiftUI
import AVFoundation
// Camera View Model
class CameraViewModel: NSObject,ObservableObject,AVCaptureFileOutputRecordingDelegate{
    @Published var session = AVCaptureSession() //An object that configures capture behavior and coordinates the flow of data from input devices to capture outputs.
    
    @Published var alert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!  //A Core Animation layer that displays video from a camera device.
    
    // MARK: Video Recorder Properties
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var previewURL: URL?
  @Published var showPreview: Bool = false
    
    // top progress bar
    @Published var recordedDuration: CGFloat = 0
    // TIMING FOR ALL VIDEOES AFTER MERGING
    @Published var maxDuration: CGFloat = 10
    
    
    func checkPermission(){
        
        // ckecking cameraModel has got permission
        
        // this switch sentence is ask permission so The user granted access to the device.
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
            
            // The system hasn't asked the user to allow access to the device.
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setUp()
                }
            }
            // The user denied access to the device.
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    
    func setUp () {
        do{
            
            self.session.beginConfiguration ()
            let cameraDevice = AVCaptureDevice.default (.builtInWideAngleCamera, for: .video, position: .back)
            let videoInput = try AVCaptureDeviceInput (device: cameraDevice!)
            let audioDevice = AVCaptureDevice.default (for: .audio)
            let audioInput = try AVCaptureDeviceInput (device: audioDevice!)
            
            
            // MARK: Audio Input
            
            if self.session.canAddInput (videoInput) && self.session.canAddInput(audioInput){
                self.session.addInput(videoInput)
                self.session.addInput(audioInput)
                
            }
            // same for output..
            
            if self.session.canAddOutput (self.output) {
                self.session.addOutput (self.output)}
            
            self.session.commitConfiguration()
            
            
        }
        
        catch{
            print (error.localizedDescription)
        }
        
    }
    
    
    func startRecording() {
        
        // MARK: Temporary URL for recording Video
        let tempURL = NSTemporaryDirectory() + "\(Date()).mov"
        output.startRecording(to: URL(fileURLWithPath: tempURL), recordingDelegate: self)
        isRecording = true
    }
    func stopRecording() {
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections:
                    [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // CREATED SUCCESSFULLY
        print(outputFileURL)
        //        self.previewURL = outputFileURL
        self.recordedURLs.append (outputFileURL)
        if self.recordedURLs.count == 1{
            self.previewURL = outputFileURL
            return
        }
        
        // CONVERTING URLs TO ASSETS
        let assets = recordedURLs.compactMap { url -> AVURLAsset in
            return AVURLAsset(url: url)
        }
        
        self.previewURL = nil
        // MERGING VIDEOS
        mergeVideos(assets: assets){ exporter in
            exporter.exportAsynchronously {
                if exporter.status == .failed{
                   
                    // HANDLE ERROR
                    print (exporter.error!)
                }
                else{
                    if let finalURL = exporter.outputURL {
                        print(finalURL)
                        
                        DispatchQueue.main.async{
                            self.previewURL = finalURL
                        }
                    }
                }
            }
        }
    }
    
    func mergeVideos(assets: [AVURLAsset], completion: @escaping (_ exporter: AVAssetExportSession) ->()) {
        
        //This object will hold my AVMutableCompositionTrack instances
        let compostion = AVMutableComposition()
        var lastTime: CMTime = .zero
        //Core Media represents time
        
       guard let videoTrack = compostion.addMutableTrack(withMediaType: .video, preferredTrackID:
        Int32(kCMPersistentTrackID_Invalid))
        else{return}
        
        guard let audioTrack = compostion.addMutableTrack(withMediaType: .audio, preferredTrackID:
         Int32(kCMPersistentTrackID_Invalid))
        else{return}
        
       
        // why asset for not start do imditly
        for asset in assets {
        // Linking Audio and Video
            do{
                try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of:
                                                asset.tracks(withMediaType: .video)[0], at: lastTime)
                // Safe Check if Video has Audio
                if !asset.tracks (withMediaType: .audio).isEmpty{
                    
                    try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of:
                                                    asset.tracks(withMediaType: .audio)[0], at: lastTime)
                }
            }
            catch{
                //HANDLE ERROR
                print (error.localizedDescription)
            }
            // Updating Last Time
            lastTime = CMTimeAdd(lastTime, asset.duration)
        }
        
        
        
        
        // MARK: Temp Output URL
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory() + "Reel-\(Date ()).mp4" )
        
        
        
        
        
        // VIDEO IS ROTATED
        // BRINGING BACK TO ORIGINAL TRANSFORM
        let layerInstructions = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        
        // MARK: Transform
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: 90 * (.pi / 180))
        transform = transform.translatedBy (x: 0, y: -videoTrack.naturalSize.height)
        layerInstructions.setTransform(transform, at: .zero)
        
        
        
        let instructions = AVMutableVideoCompositionInstruction()
        instructions.timeRange = CMTimeRange (start: .zero, duration: lastTime)
        instructions.layerInstructions = [layerInstructions]
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height:
        videoTrack.naturalSize.width)
        videoComposition.instructions = [instructions]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        
        
        guard let exporter = AVAssetExportSession(asset: compostion, presetName:
        AVAssetExportPresetHighestQuality) else{return}
        exporter.outputFileType = .mp4
        exporter.outputURL = tempURL
        exporter.videoComposition = videoComposition
        completion(exporter)
      
    }
}
