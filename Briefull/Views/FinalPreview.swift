//
//  FinalPreview.swift
//  Briefull
//
//  Created by randa on 29/07/1444 AH.
//

import SwiftUI
import AVKit

struct FinalPreview: View {
      var url: URL
        var body: some View{
            NavigationView{
                VStack{
                    VideoPlayer(player: AVPlayer(url: url))
                        .aspectRatio(contentMode:.fill)
                        .frame (width: 350, height: 450)
                        .clipShape (RoundedRectangle (cornerRadius: 38, style: .continuous))
                    
                    NavigationLink {
                        
                    } label: {
                        
                        Text("Publish")
                        
                            .padding(.horizontal, 20)
                            .modifier(Items.ButtonModifier())
                    }
                }
            }

        }
    }

