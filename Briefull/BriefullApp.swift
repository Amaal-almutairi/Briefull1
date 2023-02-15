//
//  BriefullApp.swift
//  Briefull
//
//  Created by Amaal Almutairi on 24/07/1444 AH.
//

import SwiftUI
//import FirebaseCore
//import Firebase

//enum Route: Hashable {
//    case login
//}


@main
struct BriefullApp: App {
    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var coordinator = Coordinator()
//    @StateObject var session: SessionStore = SessionStore()
////    @StateObject var  vmCardService :VideotCardService = VideotCardService()
//    @StateObject var profileService:ProfileService = ProfileService()
//    @StateObject var followService:FollowService = FollowService()

    var body: some Scene {
        WindowGroup {
            NavigationView{
               HomeView()
            }
//            .environmentObject(SessionStore()).environmentObject(ProfileService()).environmentObject(FollowService())
                //.environmentObject(VideotCardService())
        }
        }
    }





class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        print("firebase...")
//        FirebaseApp.configure()
        return true
    }
}