//
//  ProductUpLoadView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI
import PhotosUI

struct ProductUpLoadView: View {
    
    @State var inputText: String = ""
    @State var inputText2: String = ""
    @State var inputText3: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("물물교환할 상품을 올려보세요.")
                .font(.title3)
            SelectPhotos()
            
            TextField("상품명", text: $inputText)
                .textFieldStyle(.roundedBorder)
            
            TextField("가격 입력", text: $inputText2)
                .textFieldStyle(.roundedBorder)
            
            // 바꾸고 싶은 물건 태그 
            // 💁 Tag 선택 View
//            Group {
//                SelectTagView(memoSelectedTags: $viewModel.memoSelectedTags)
//                    .frame(maxWidth: .infinity)
//                    .aspectRatio(contentMode: .fit)
//                    .id(1)
//            }
//            .foregroundStyle(Color.textColor)
//            .padding(.bottom)
//            .buttonStyle(.borderedProminent)
//            .padding(.horizontal, 20)
//            .tint(viewModel.memoTitle.isEmpty || viewModel.memoContents.isEmpty ? Color(.systemGray5) : Color.blue)
//            .padding(.bottom, 20)
//            
            
            
            
            // TexEditor 여러줄 - 긴글 의 text 를 입력할때 사용
            TextEditor(text: $inputText3)
                .frame(height: 250) // 크기 설정
                .colorMultiply(Color.gray.opacity(0.5))
                
        }
        .padding(.horizontal)
    }
    
   
}

#Preview {
    ProductUpLoadView()
}
