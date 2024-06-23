//
//  DIContainer.swift
//  MulMulMarket
//
//  Created by 정정욱 on 5/2/24.
//

import Foundation


class DIContainer: ObservableObject {
    var services: ServiceType // 서비스 목록관리 추가

    init(
        services: ServiceType
    ) {
        self.services = services
    }
}
