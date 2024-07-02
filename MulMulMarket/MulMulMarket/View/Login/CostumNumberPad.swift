//
//  CostumNumberPad.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//


import SwiftUI

struct CostumNumberPad: View {
    
    @Binding var value: String
    var isVerify: Bool // isVerify가 true라면, 입력 길이를 6자리로 제한 (파베에서 날라오는 인증 코드)
    
    var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "0", "delete.left.fill"]    // nomor pad data
    
    var body: some View {
        
        GeometryReader { reader in
            
            VStack {
                // 3개의 열을 생성하며, 각 열은 GridItem(.flexible())로 균등한 크기를 가집니다.
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 20), count: 3), spacing: 15) {
                    
                    // 반복하여 버튼을 생성
                    ForEach(rows,id: \.self) { value in
                        
                        Button(action: {buttonAction(value: value)}) {
                            
                            ZStack {
                                
                                if value == "delete.left.fill" {
                                    
                                    Image(systemName: value)
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                else {
                                    
                                    Text(value)
                                        .font(.title2)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.black)
                                }
                            }
                            // GeometryReader에서 가져온 프레임을 사용하여 버튼의 너비와 높이를 계산합니다. actualWidth와 actualHeight는 각각 전체 너비와 높이에서 40을 뺀 값입니다. 이 값들을 각각 3과 4로 나누어 버튼의 크기를 결정합니다.
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .disabled(value == "" ? true : false) // 값이 없는 빈 버튼은 눌리지 않도록
                    }
                }
            }
            
        }
        .padding()
    }
    
    func getWidth(frame: CGRect) -> CGFloat {
        // 화면의 전체 너비를 가져와요.
        let width = frame.width
        
        // 전체 너비에서 40을 빼요. (버튼 사이의 간격을 고려해서 빼는 거예요)
        let actualWidth = width - 40
        
        // 버튼 하나의 너비는 이 남은 너비를 3으로 나눈 값이에요.
        return actualWidth / 3
    }
    
    func getHeight(frame: CGRect) -> CGFloat {
        // 화면의 전체 높이를 가져와요.
        let height = frame.height
        
        // 전체 높이에서 40을 빼요. (버튼 사이의 간격을 고려해서 빼는 거예요)
        let actualHeight = height - 40
        
        // 버튼 하나의 높이는 이 남은 높이를 4로 나눈 값이에요.
        return actualHeight / 4
    }
    
    func buttonAction(value: String) {
        
        if value == "delete.left.fill" && self.value != "" {
            self.value.removeLast()
        }
        
        if value != "delete.left.fill" {
            
            if isVerify {
                
                if self.value.count < 6 {
                    self.value.append(value)
                }
            }
            else {
                self.value.append(value)
            }
        }
    }
}
