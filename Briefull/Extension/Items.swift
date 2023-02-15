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
                .frame(width:frameSize,height: 55)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                
               
        }
    }
    
    struct ButtonModifierRequest: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.headline)
               // .frame(maxWidth: .infinity)
                .frame(width:70,height: 20)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                
               
        }
    }
    
    struct TexStyleModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.headline)
                .font(.system(size: 20))
                .frame(width:frameSize,height: 55)
               
            
        }
    }
    
    struct TextFieldStyleModifier: ViewModifier {
        @State var frameSize: CGFloat = UIScreen.main.bounds.width - 20 // display the content in all iphones in the same size(width only)

        func body(content: Content) -> some View {
            content
                .font(.headline)
                .font(.system(size: 16))
                .frame(width:frameSize,height: 55)
                .foregroundColor(.gray)
                .background(Color(.white).cornerRadius(10))
                    .padding()
            
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
