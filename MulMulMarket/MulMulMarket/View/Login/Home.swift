//
//  Home.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//

//
//  Home.swift
//  PhoneAuth
//
//  Created by Sabina Huseynova on 06.12.21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Home: View {
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Logged In Successfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button(action: {
                let firebaseAuth = Auth.auth()
                       do {
                           try firebaseAuth.signOut()
                           withAnimation{ status = false }
                       }
                       catch let signOutError as NSError {
                           print ("Error signing out: %@", signOutError)
                       }
                
            }, label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            })
        }
        
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

