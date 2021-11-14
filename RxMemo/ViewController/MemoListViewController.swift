//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by Junho Yoon on 2021/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func bindViewModel() {
     
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        Observable.zip(listTableView.rx.itemSelected,
                       listTableView.rx.modelSelected(Memo.self))
            .do(onNext: { [unowned self] (indexPath, _) in
                self.listTableView.deselectRow(at: indexPath, animated: true)
                
            })
                .map { $0.1 }
                .bind(to: viewModel.detailAction.inputs)
                .disposed(by: rx.disposeBag)
        
        listTableView.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
    }
}
