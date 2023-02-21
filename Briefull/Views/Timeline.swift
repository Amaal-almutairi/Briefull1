//
//  Timeline.swift
//  Briefull
//
//  Created by Amaal Almutairi on 17/07/1444 AH.
//

import SwiftUI
import GiphyUISDK
import SDWebImageSwiftUI

struct Timeline: View {
    
//    @State var emojiList:[String] = []
    @State var showImojiSheet = false
    @State var gifdata : [String] = []
    @State var present = false
    @State var url = ""
    
    var body: some View {
//        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                  .rectangle()
                 
                    ZStack{
                        Rectangle()
                            .rectangleImoji()
                        VStack(alignment: .leading){
                            Text("Maha")
                            Divider()
                                .foregroundColor(.black)
                                .frame(width:UIScreen.main.bounds.width - 50, height: 50)
                            HStack(alignment: .center){
                                ScrollView(.horizontal, content: {
                                    HStack(alignment: .center, spacing: 5){
                                        ForEach(gifdata, id: \.self){url in
                                            Spacer (minLength: 0)
                                            // Animated Image Will Load GIF
                                            
                                            AnimatedImage(url: URL(string: url)!)
                                                .resizable()
                                                .clipShape(Circle())
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40, height: 40)
                                            
                                            
                                            
                                        }.onChange(of: url, perform: { value in
                                            self.gifdata.append(value)
                                            
                                            
                                        })
                                    }
                                    
                                    //             .toolbar(content: {
                                    //               Button(action: {present.toggle()},
                                    //                           label: { Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    //                            .font(.title2)
                                    //                    })
                                    //                })
                                }).padding()
                                //                            .fullScreenCover(isPresented: $present, content: {
                                //                                    GIFControllerViewModel(url: $url, pressent: $present)
                                //                                })
                                //                            Circle()
                                //                            .frame(width:UIScreen.main.bounds.width - 40, height: 40).cornerRadius(20)
                                //                            .foregroundColor(.gray.opacity(0.40))
                                //                            .padding(.bottom,-35).padding(.top).padding(.leading, -120)
                                //                            Spacer()
                                //                            Image(systemName: "plus.circle")
                                //                                .padding(.top,60).padding(.trailing, 25)
                                //                            .sheet(isPresented: $showImojiSheet) {
                                //                                ImojiSheet()
                                //                                    .presentationDetents([.height(470)])
                                //                                    .presentationDragIndicator(.visible)
                                //                            }
                                
                                Button(action: {
                                    //                                   showImojiSheet.toggle()
                                    present.toggle()
                                },
                                       label: { Image(systemName: "plus.circle")
                                        .padding(.trailing, 25)
                                        .font(.title2)
                                }).fullScreenCover(isPresented: $present, content: {
                                    GIFControllerViewModel(url: $url, pressent: $present)
                                })
                            }
                        }.padding()
                    }
                          
//                        ForEach(emojiList, id: \.self) { emoji in
//                            Text("\(emoji)")
//                     }
                         
                    }
//                .padding(.top, 400)
                }
            .navigationTitle("Time line")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action:{}){
                NavigationLink(destination: UserProfile( user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))){
                    Image(systemName: "person.badge.plus")
                }
            }).accentColor(.black)
      
            }
            
        
//            .navigationBarItems(trailing:
//        NavigationLink(destination: AddFriends(), label: {
//                    Image(systemName: "person.badge.plus")
//                        .accentColor(.black)
//            }))
      //  }
    }


struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
    }
}
