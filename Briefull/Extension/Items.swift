//
//  Items.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

struct Items: View {
    struct ButtonModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.headline)
               // .frame(maxWidth: .infinity)
                .frame(width:frameSize,height: 44)
                .background(Color("mauve"))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
               
        }
    }
    
    struct ButtonModifierRequest: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.headline)
               // .frame(maxWidth: .infinity)
                .frame(width:70,height: 20)
                .background(Color("mauve"))
                .foregroundColor(.white)
                .cornerRadius(20)
                
               
        }
    }
    
    struct TexStyleModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .font(.system(size: 20))
                .frame(width:frameSize,height: 55)
               
            
        }
    }
    struct TextModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                
                .font(.system(size: 14))
                .padding(.top,16)
                .padding(.bottom, 8.0)
                .padding(.leading, -180)

            
        }
    }
    
    struct TitlesStyleModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .frame(width:frameSize,height: 30)

               
            
        }
    }
    
    struct TextFieldStyleModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.callout)
                .font(.system(size: 16))
                .padding(16.0)
                .frame(width:frameSize,height: 44)
                .background(Color("LGray").cornerRadius(10))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            
        }
    }
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Items_Previews: PreviewProvider {
    static var previews: some View {
        Items()
    }
}
