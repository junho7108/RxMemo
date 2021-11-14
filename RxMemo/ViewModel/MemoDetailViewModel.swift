//
//  MemoDetailViewModel.swift
//  RxMemo
//
//  Created by Junho Yoon on 2021/11/07.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    let memo: Memo
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "Ko_kr")
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df
    }()
    
    var contents: BehaviorSubject<[String]>
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, stroage: MemoStorageType) {
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            dateFormatter.string(from: memo.insertDate)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: stroage)
    }
    
    
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true)
            .asObservable().map { _ in }
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action<String, Void> { input in
            self.storage.update(memo: memo, content: input)
                .subscribe(onNext: { updated in
                    self.contents.onNext([
                        updated.content,
                        self.dateFormatter.string(from: updated.insertDate)
                    ])
                    
                })
                .disposed(by: self.rx.disposeBag)
            
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "메모 편집", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            
            let composeScnene = Scene.compose(composeViewModel)
            return self.sceneCoordinator.transition(to: composeScnene, using: .modal, animated: true)
                .asObservable()
                .map { _ in }
        }
    }
}
