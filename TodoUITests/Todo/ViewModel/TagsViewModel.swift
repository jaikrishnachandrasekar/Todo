//
//  TagsViewModel.swift
//  Todo
//
//  Created by admin on 3/12/22.
//

import UIKit

class TagsViewModel: NSObject {

    var reloadTableView: (() -> Void)?
    
    var groupedData = [(String, [TaskDescription])](){
      
        didSet{
            self.reloadTableView?()
        }
        
    }
    
    
    override init(){
        super.init()
    }
    
    func dataToGroup(data : [TaskDescription]) -> [((String), [TaskDescription])]{
        let tags = data.map{$0.tag}
        let uniqueValues = Array(Set(tags))
        var groupData : [(String, [TaskDescription])] = [];
        for unique in uniqueValues{
            let singleData = data.filter{$0.tag == unique}
            groupData.append((unique, singleData))
        }
        return groupData
    }
    
    func getTableData(){
        ApiController.instance.getTodoListData(limit: 1000)
       {(data) in
            self.groupedData = self.dataToGroup(data: data);
       }
    }
    
}
