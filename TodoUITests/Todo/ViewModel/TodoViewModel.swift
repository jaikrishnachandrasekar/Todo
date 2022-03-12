//
//  TodoViewModel.swift
//  Todo
//
//  Created by admin on 3/11/22.
//

import UIKit

class TodoViewModel: NSObject {
    

    var reloadTableView: (() -> Void)?

    var todoListData = [TaskDescription](){
        didSet{
            self.reloadTableView?()
        }
    }
    
    override init()
    {
        super.init()
    }
    
    func fetchTableData(){
        ApiController.instance.getTodoListData(){(data) in
            self.todoListData = data
        }
    }
    
    
    func toggleIsCompleted(sender: CustomTapGestureRecognizer){
        
        ApiController.instance.toggleCompleted(sender: sender){(data) in
            self.fetchTableData()
        }
        
    }
}

