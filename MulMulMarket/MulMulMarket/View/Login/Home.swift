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
    
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ()
            } else {
                LoginView()
            }
        }
    }
        
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

