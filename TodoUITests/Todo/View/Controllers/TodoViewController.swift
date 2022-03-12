//
//  ViewController.swift
//  Todo
//
//  Created by admin on 3/11/22.
//

import UIKit

class TodoTableViewCell : UITableViewCell{
    @IBOutlet weak var isCompletedImage: UIImageView!
    @IBOutlet weak var priority: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UILabel!
}


class TodoViewController: UIViewController {
    
    var todoViewModel : TodoViewModel!

    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        todoTableView.separatorStyle = .none
        todoTableView.dataSource = self
    }
    
        
    func initViewModel() {
        self.todoViewModel = TodoViewModel()
        self.todoViewModel.fetchTableData()
        self.todoViewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.todoTableView.reloadData()
            }
        }
     }
    
}

// MARK: - TapGestureWithCustomSender

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var task: TaskDescription?
}

// MARK: - TableViewDataSource


extension TodoViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoViewModel.todoListData.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TodoTableViewCell = self.todoTableView.dequeueReusableCell(withIdentifier: "cell") as? TodoTableViewCell ?? TodoTableViewCell()
        
        cell.cardView.layer.masksToBounds = false
        cell.cardView.layer.shadowColor = UIColor.lightGray.cgColor;
        cell.cardView.layer.shadowOffset = CGSize.zero;
        cell.cardView.layer.shadowOpacity = 0.5
        cell.cardView.layer.shadowRadius = 4
        cell.cardView.layer.cornerRadius = 8.0
        
        let todoListData = todoViewModel.todoListData;

        cell.title.text = todoListData[indexPath.row].title
        cell.tags.text = todoListData[indexPath.row].tag
        cell.priority.backgroundColor = todoListData[indexPath.row].priority?.getColor()
        
        if(todoListData[indexPath.row].isCompleted){
            cell.isCompletedImage.image = UIImage(named: "Checked")
            cell.isCompletedImage.tintColor = UIColor.purple
        }
        else{
            cell.isCompletedImage.image = UIImage(named: "Unchecked")
            cell.isCompletedImage.tintColor = UIColor.gray
        }
        
                
        let tapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(completedClicked(sender:)))
        tapGestureRecognizer.task = todoListData[indexPath.row]
        cell.isCompletedImage.isUserInteractionEnabled = true
        cell.isCompletedImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    @objc func completedClicked(sender : CustomTapGestureRecognizer){
        todoViewModel.toggleIsCompleted(sender: sender);
    }
    
}
