//
//  CountTimer.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/30/24.
//


import Foundation
import Combine

// CountTimer 클래스는 시간이 지남에 따라 progress 값을 증가시키는 간단한 타이머
class CountTimer: ObservableObject{
    
    @Published var progress: Double
    private var interval: TimeInterval // 타이머가 한 사이클을 완료하는 데 걸리는 시간
    private var max: Int // progress가 이 값을 초과하면 0으로 리셋
    private let publisher: Timer.TimerPublisher // 일정 간격으로 이벤트를 발행하는 Combine 퍼블리셔
    private var cancellable: Cancellable? // 타이머 퍼블리셔에 대한 구독을 참조하는 속성입니다. 필요할 때 구독을 취소할 수 있도록 합니다.
    
    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default) // 0.1 초마다 이벤트 발생
    }
    func start() {
        // 타이머가 0.1초마다 알림을 보내기 시작해요
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: { _ in
            // 새로운 진행 상황 값을 계산해요
            var newProgress = self.progress + (0.1 / self.interval)
            
            // 만약 새로운 진행 상황 값이 최대 값을 넘으면, 다시 0으로 돌아가요
            if Int(newProgress) >= self.max { newProgress = 0 }
            
            // 계산된 새로운 진행 상황 값을 저장해요
            self.progress = newProgress
        })
    }

    func advancePage(by number:Int) { // 다음 페이지
        let newProgress = Swift.max((Int(self.progress) + number) % self.max, 0) // 진행 상황 값이 0보다 작아지지 않도록 합니다.
        self.progress = Double(newProgress) // 새로운 진행 상황 값을 설정합니다.
    }
}
