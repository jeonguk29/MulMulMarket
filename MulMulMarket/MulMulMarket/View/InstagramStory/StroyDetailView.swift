//
//  StroyDetailView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/30/24.
//

import SwiftUI

struct StroyDetailView: View, Identifiable {
    
    let id = UUID()
    var honeyMoon: Destination
    
    var images: [String] = ["photo-athens-greece", "photo-barcelona-spain", "photo-budapest-hungary", "photo-dubai-emirates", "photo-emaraldlake-canada", "photo-grandcanyon-usa"] // 각각의 물건 이미지 상세 샷들이 들어올 것 임
    
    // 타이머 없이 수동으로 페이지를 관리하기 위해 @State 변수 사용
    @State private var currentPage: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // 현재 사진을 보여주는 부분
                Image(self.images[currentPage])
                    .resizable()
                    .cornerRadius(24)
                    .scaledToFit()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .overlay(
                        VStack(alignment: .center, spacing: 12) {
                            Text(honeyMoon.place.uppercased())
                                .foregroundColor(Color.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .shadow(radius: 1)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 4)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(height: 1),
                                    alignment: .bottom
                                )
                            
                            Text(honeyMoon.country.uppercased())
                                .foregroundColor(Color.black)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .frame(minWidth: 85)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    Capsule().fill(Color.white)
                                )
                        }
                            .frame(minWidth: 280)
                            .padding(.bottom, 50),
                        alignment: .bottom
                    )
                
                // 로딩 바 (진행 상태 표시)
                HStack(alignment: .center, spacing: 4) {
                    // 각 사진에 대한 로딩바를 만듬
                    ForEach(self.images.indices) { image in
                        LoadingBar(progress: min(max((CGFloat(self.currentPage) - CGFloat(image)), 0.0), 1.0))
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
                            self.advancePage(by: -1)
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.advancePage(by: 1)
                        }
                }
            }
        }
    }
    
    // 페이지를 수동으로 이동시키는 함수
    private func advancePage(by number: Int) {
        let newPage = (self.currentPage + number) % self.images.count
        self.currentPage = newPage < 0 ? self.images.count - 1 : newPage
    }
}

#Preview {
    StroyDetailView(honeyMoon: destinationArray[1])
        .previewLayout(.fixed(width: 375, height: 600))
}
