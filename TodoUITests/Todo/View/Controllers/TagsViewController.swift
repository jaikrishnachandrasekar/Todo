//
//  TagsViewController.swift
//  Todo
//
//  Created by admin on 3/11/22.
//

import UIKit

class TagsTableViewCell : UITableViewCell{
    @IBOutlet weak var sectionHeaderView: UIView!
    @IBOutlet weak var lblSectionHeaderTitle: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var lblTaskTitle: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
}

class TagsViewController: UIViewController{
    
    var tagsViewModel : TagsViewModel!
    
    @IBOutlet weak var tagsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        tagsTableView.separatorStyle = .none
        tagsTableView.dataSource = self
    }
    
    func initViewModel(){
        self.tagsViewModel = TagsViewModel()
        self.tagsViewModel.getTableData()
        self.tagsViewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tagsTableView.reloadData()
            }
        }
    }
    
}

extension TagsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tagsViewModel.groupedData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tagsViewModel.groupedData[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TagsTableViewCell = self.tagsTableView.dequeueReusableCell(withIdentifier: "tagsCell") as? TagsTableViewCell ?? TagsTableViewCell()
        
        cell.cardView.layer.masksToBounds = false
        cell.cardView.layer.shadowColor = UIColor.lightGray.cgColor;
        cell.cardView.layer.shadowOffset = CGSize.zero;
        cell.cardView.layer.shadowOpacity = 0.5
        cell.cardView.layer.shadowRadius = 4
        cell.cardView.layer.cornerRadius = 8.0
        
        let sectionData = tagsViewModel.groupedData[indexPath.section]
        
        if(indexPath.row == 0){
            cell.lblSectionHeaderTitle.text = sectionData.0
            cell.cardView.isHidden = false
        }
        else{
            cell.sectionHeaderView.isHidden = true
            cell.headerHeight.constant = 0;
        }
        
        cell.lblTaskTitle.text = sectionData.1[indexPath.row].title
        cell.priorityView.backgroundColor = sectionData.1[indexPath.row].priority?.getColor()

        return cell
    }
}
