//
//  StroyTestView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/30/24.
//

import SwiftUI

struct StroyTestView: View {
    var imageNames: [String] = ["photo-athens-greece", "photo-barcelona-spain", "photo-budapest-hungary", "photo-dubai-emirates", "photo-emaraldlake-canada", "photo-grandcanyon-usa"]
    
    @ObservedObject var storyTimer = StoryTimer(items: 6, interval: 3.0)
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: . top){
                Image(self.imageNames[Int(self.storyTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea (.all)
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: nil, alignment: .center)
                    .animation(.none)
                HStack(alignment: .center, spacing: 4){
                    ForEach(self.imageNames.indices){ x in
                        LoadingRectangle(progress: min( max ( (
                            CGFloat(self.storyTimer.progress) - CGFloat(x)), 0.0), 1.0) )
                        .frame(width: nil, height: 2, alignment: .leading)
                        .animation(.linear)
                    }
                }
                .padding()
            }
        }
        .onAppear{self.storyTimer.start()}
    }
}

#Preview {
    StroyTestView()
}
