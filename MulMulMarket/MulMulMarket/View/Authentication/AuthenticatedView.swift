//
//  AuthenticatedView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 5/2/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

//#Preview {
//    AuthenticatedView(authViewModel: <#AuthenticationViewModel#>)
//}
