//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by Junho Yoon on 2021/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
