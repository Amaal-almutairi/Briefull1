//
//  Timeline.swift
//  Briefull
//
//  Created by Amaal Almutairi on 17/07/1444 AH.
//

import SwiftUI

struct Timeline: View {
    
//    @State var emojiList:[String] = []
    @State var showImojiSheet = false
    
    var body: some View {
//        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                  .rectangle()
                 
                    ZStack{
                        Rectangle()
                            .rectangleImoji()
                        Text("")
                        Divider()
                            .foregroundColor(.black)
                            .frame(width:UIScreen.main.bounds.width - 50, height: 50)
                        HStack{
                            Circle()
                            .frame(width:UIScreen.main.bounds.width - 40, height: 40).cornerRadius(20)
                            .foregroundColor(.gray.opacity(0.40))
                            .padding(.bottom,-35).padding(.top).padding(.leading, -120)
                            Spacer()
                            Image(systemName: "plus.circle")
                                .padding(.top,60).padding(.trailing, 25)
                            .sheet(isPresented: $showImojiSheet) {
                                ImojiSheet()
                                    .presentationDetents([.height(470)])
                                    .presentationDragIndicator(.visible)
                            }
                        }
                          
//                        ForEach(emojiList, id: \.self) { emoji in
//                            Text("\(emoji)")
//                     }
                         
                    }.padding(.top, 400)
                }
      
            }
            .navigationTitle("Time line")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action:{}){
            NavigationLink(destination: UserProfile( user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"))){
                Image(systemName: "person.badge.plus")
            }
        }).accentColor(.black)
        
//            .navigationBarItems(trailing:
//        NavigationLink(destination: AddFriends(), label: {
//                    Image(systemName: "person.badge.plus")
//                        .accentColor(.black)
//            }))
      //  }
    }
}

//struct Timeline_Previews: PreviewProvider {
//    static var previews: some View {
//        Timeline()
//    }
//}
