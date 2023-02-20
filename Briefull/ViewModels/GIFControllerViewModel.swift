//
//  GIFControllerViewModel.swift
//  Briefull
//
//  Created by Maha Binmadhi on 13/02/2023.
//

import Foundation
import GiphyUISDK
import SwiftUI

struct GIFControllerViewModel : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return GIFControllerViewModel.Coordinator(parent: self)
    }
    
    @Binding var url : String
    @Binding var pressent : Bool
    
    func makeUIViewController(context: Context) -> GiphyViewController {
        
        Giphy.configure(apiKey: "sQi0GANsboB76bFOZSrVBBo9f53sQhz7")
        let controller = GiphyViewController()
        controller.mediaTypeConfig = [.emoji,.gifs,.stickers]
        GiphyViewController.trayHeightMultiplier = 1.05
        controller.theme = GPHTheme(type: .light)
        
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: GiphyViewController, context:
    Context)
    {
        
    }
    
    class Coordinator : NSObject,GiphyDelegate {
        
        var parent : GIFControllerViewModel
        init(parent: GIFControllerViewModel) {
            self.parent = parent
        }
        
        func didDismiss(controller: GiphyViewController?) {
            
        }
        func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
            
            let url = media.url(rendition: .fixedWidth, fileType: .gif)
            parent.url = url ?? ""
            parent.pressent.toggle()
            
        }
    }
}
