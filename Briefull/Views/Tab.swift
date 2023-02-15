//
//  Tab.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

struct Tab: View {
    @EnvironmentObject var session: SessionStore
// user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus")
    
//    @State var selection = 2
    @State var selection = "person.fill"
//    @State var edg = UIApplication.shared.windows.first?.safeAreaInsets
    var tabs = ["person.fill","camera.viewfinder","camera.on.rectangle"]
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selection){
                Profile()
                    .tag("person.fill")
                Vlog()
                    .tag("camera.viewfinder")
                Timeline()
                    .tag("camera.on.rectangle")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0){
                ForEach(tabs,id: \.self) {
                    image in
                    TabButton(image: image, selection: $selection)
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
//            .shadow(color: Color("mauve"), radius: 5, x: 5, y: 5)
//            .shadow(color: Color("mauve"), radius: 5, x: -5, y: -5)

            .padding(.horizontal)
//            .padding(.bottom, edg!.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard,edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
    }
}

struct TabButton:View {
    
    var image: String
    @Binding var selection: String
    
    var body: some View{
        
        Button(action:{selection = image}) {
            Image(systemName: "\(image)").foregroundColor(selection == image ? Color("mauve"): Color.gray).padding()
        }
    }
}



struct Tab_Previews: PreviewProvider {
    var session: SessionStore
    static var previews: some View {
        Tab().environmentObject(SessionStore())
    }
}

/*
 VStack{
     NavigationView{
         VStack{
             TabView(selection: $selection) {
                 Profile().tabItem {  Text("Profile") }.tag(1)
                 Vlog().tabItem { Text("Vlog") }.tag(2)
                 Timeline().tabItem { Text("TimeLine") }.tag(3)
             }
             
         }
     }
 }
 */
