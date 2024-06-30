//
//  StroyTestView2.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/30/24.
//

import SwiftUI

struct StroyTestView2: View {
    
    var images: [String] = ["photo-athens-greece", "photo-barcelona-spain", "photo-budapest-hungary", "photo-dubai-emirates", "photo-emaraldlake-canada", "photo-grandcanyon-usa"] // 각각의 물건 이미지 상세 샷들이 들어올 것 임
    
    @ObservedObject var countTimer:CountTimer = CountTimer(items: 6,interval: 4.0) // 4초마다 사진을 넘어가도록 설정
    
    var body: some View {
        GeometryReader{geometry in
            // 현재 사진을 보여주는 부분
            Image(self.images[Int(self.countTimer.progress)])
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .frame(width: geometry.size.width, height: nil, alignment: .center)
                .animation(.none)
            
            // 로딩 바 (진행 상태 표시)
            HStack(alignment: .center, spacing: 4) {
                // 각 사진에 대한 로딩바를 만듬
                ForEach(self.images.indices) { image in
                    LoadingBar(progress: min(max((CGFloat(self.countTimer.progress) - CGFloat(image)), 0.0), 1.0))
                        .frame(width: nil, height: 2, alignment: .leading)
                        .animation(.linear)
                }
            }
            .padding()
            
            // 화면 탭하여 이전/다음 사진으로 이동
            // 투명한 Rectangle들을 배치하고, 이를 탭하면 이전 사진이나 다음 사진으로 이동
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.countTimer.advancePage(by: -1)
                    }
                Rectangle()
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.countTimer.advancePage(by: 1)
                    }
            }
            
        }
        .onAppear{
            self.countTimer.start()
        }
    }
}
#Preview {
    StroyTestView2()
}
