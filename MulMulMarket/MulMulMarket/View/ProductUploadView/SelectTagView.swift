//
//  SelectTagView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI

struct SelectTagView: View {
    @State private var isShowingView: Bool = false
    @Binding var memoSelectedTags: [String]
    @State var newTag: String = ""
    @Namespace private var customNamespace // 추가된 네임스페이스
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .lastTextBaseline){
                Text("태그")
                    .font(.headline)
                    .bold()
                Spacer()
                Button {
                    withAnimation {
                        // Toggle the view's visibility
                        isShowingView.toggle()
                    }
                    
                } label: {
                    Text("+")
                        .rotationEffect(isShowingView ? .init(degrees: 45) : .zero)
                        .foregroundStyle(Color.black)
                }.buttonStyle(.plain)
            }  //:HSTACK
            Rectangle()
                .frame(height: 0.5)
            Rectangle()
                .frame(height: 40)
                .cornerRadius(10)
                .foregroundStyle(Color.gray.opacity(0.17))
                .overlay(
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            // 태그 선택할때 마다 표시
                            ForEach(memoSelectedTags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.bold14)
                                    .padding(5)
                                    .foregroundColor(Color.bgColor3)
                                    .padding(.horizontal, 8)
                                    .background(
                                        Capsule()
                                            .foregroundColor(.accentColor)
                                    )
                                    .onTapGesture {
                                        memoSelectedTags.removeAll(where: {$0 == tag})
                                    }
 
                            }
                            if memoSelectedTags.count < 5 {
                                TextField("#태그", text: $newTag, onCommit: edited)
                                    .font(.bold14)
                                    .padding(5)
                                    .foregroundColor(Color.bgColor3)
                                    .padding(.horizontal, 8)
                                    .background(
                                        Capsule()
                                            .foregroundColor(.accentColor)

                                    )
                            }
                        }
                        .padding(5)
                    }
                        .scrollIndicators(.hidden)
                )
                .onTapGesture {
                    if isShowingView == false {
                        withAnimation {
                            // Toggle the view's visibility
                            isShowingView.toggle()
                        }
                    }
                }
            
            
            if isShowingView {
                // View that appears from bottom to top
                VStack {
                    
                    Text("어떤 태그를 선택하시겠어요?")
                        .font(.bold18)
                    VStack {
                        GeometryReader { geometry in
                            FlexibleView(availableWidth: geometry.size.width,
                                         data: memoSelectedTags, // 임의의 태그 리스트 사용
                                         spacing: 15,
                                         alignment: .center) { item in
                                Button(action: {
                                    toggleTag(item)
                                }, label: {
                                    Text("#\(item)")
                                }).buttonStyle(
                                    memoSelectedTags.contains(item) ? Color.pink : Color.greyLight
                                )
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(contentMode: .fit)
                            }.frame(maxWidth: .infinity)
                            
                        } // VStack
                    } // ScrollView
                    
                } //:VSTACK
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            isShowingView = false
        }
        
    }
    
    private func toggleTag(_ tag: String) {
        // 이미 선택된 태그인지 확인
        let isTagSelected = memoSelectedTags.contains(tag)
        
        if isTagSelected {
            // 이미 선택된 경우, 해당 태그를 제거
            memoSelectedTags.removeAll { $0 == tag }
        } else {
            // 선택되지 않은 경우, 최대 5개까지만 추가
            if memoSelectedTags.count < 5 {
                memoSelectedTags.append(tag)
            }
        }
    }
    
    private func edited() {
        toggleTag(self.newTag)
        self.newTag = ""
    }
}

#Preview {
    SelectTagView(memoSelectedTags: .constant(["태그1", "그2","태1", "태그277","1", "태그52","태그yy1", "태그7802"]))
}
