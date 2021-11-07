//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Junho Yoon on 2021/11/07.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
