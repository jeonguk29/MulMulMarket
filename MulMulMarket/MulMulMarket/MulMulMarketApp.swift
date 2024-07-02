//
//  MulMulMarketApp.swift
//  MulMulMarket
//
//  Created by 정정욱 on 5/2/24.
//

import SwiftUI
import Firebase

@main
struct MulMulMarketApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
      }
        
        // 폰인증을 위한 코드
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
        }
    }
}
