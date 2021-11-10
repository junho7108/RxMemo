//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by Junho Yoon on 2021/11/07.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {
   
    var viewModel: MemoDetailViewModel!
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var deleteButton: UIToolbar!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    func bindViewModel() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
