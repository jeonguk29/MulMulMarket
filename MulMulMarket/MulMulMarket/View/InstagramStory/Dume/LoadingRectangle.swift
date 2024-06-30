//
//  LoadingRectangle.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/30/24.
//

import SwiftUI

struct LoadingRectangle: View {
    
    var progress : CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)
                
                Rectangle()
                    .frame(width: geometry.size.width * self.progress, height: nil, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    LoadingRectangle(progress: 3.0)
}
