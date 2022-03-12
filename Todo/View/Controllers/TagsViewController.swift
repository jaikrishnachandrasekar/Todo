//
//  TagsViewController.swift
//  Todo
//
//  Created by admin on 3/11/22.
//

import UIKit

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

class TagsTableViewCell : UITableViewCell{
    
    @IBOutlet weak var singleTagTableView: UITableView!
    
}

class TagsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tagsTableView: UITableView!
    
    var groupedData : [(String, [TaskDescription])] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tagsTableView.dataSource = self
        tagsTableView.delegate = self
        
        
        
         DataController.instance.getTodoListData(limit: 100)
        {(data) in
            let tags = data.map{$0.tag}
            
            let uniqueValues = Array(Set(tags))
            
            
            for unique in uniqueValues{
                let groupData = data.filter{$0.tag == unique}
                self.groupedData.append((unique, groupData))
            }
            
            DispatchQueue.main.async {
                self.tagsTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedData.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return  groupedData[section].1.count
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedData[section].0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tagsTableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        
        cell.textLabel?.text = groupedData[indexPath.section].1[indexPath.row].title
        
        return cell
    }
    

}
