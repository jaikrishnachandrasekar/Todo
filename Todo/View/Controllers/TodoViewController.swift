//
//  ViewController.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import UIKit

class TodoTableViewCell : UITableViewCell{
    @IBOutlet weak var isCompletedImage: UIImageView!
    
    @IBOutlet weak var priority: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UILabel!
}


class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todolistData : [TaskDescription] = [];
    
    @IBOutlet weak var todoTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getTableData()
        todoTableView.separatorStyle = .none
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    func getTableData(){
        DataController.instance.getTodoListData(){(data) in
            self.todolistData = data;
            
            DispatchQueue.main.async {
                self.todoTableView.reloadData();
            }
        }
        
    }

    @objc func toggleIsCompleted(sender: CustomTapGestureRecognizer){
        guard let task = sender.task else { return }

        let url = URL(string: "http://167.71.235.242:3000/todo/\(task.id)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let parameters : [String : Any] = [
            "title" : task.title,
            "author" : "jai",
            "tag" : task.tag,
            "is_completed" : !task.isCompleted,
            "priority" : task.priority?.rawValue ?? Priority.low.rawValue,
            "id" : task.id
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                    if let _ = data {
                
                        self.getTableData()
                    }
        }.resume()
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolistData.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TodoTableViewCell = self.todoTableView.dequeueReusableCell(withIdentifier: "cell") as? TodoTableViewCell ?? TodoTableViewCell()
        
        cell.cardView.layer.masksToBounds = false
        cell.cardView.layer.shadowColor = UIColor.lightGray.cgColor;
        cell.cardView.layer.shadowOffset = CGSize.zero;
        cell.cardView.layer.shadowOpacity = 0.5
        cell.cardView.layer.shadowRadius = 4
        cell.cardView.layer.cornerRadius = 8.0

        cell.title.text = todolistData[indexPath.row].title
        cell.tags.text = todolistData[indexPath.row].tag
        cell.priority.backgroundColor = todolistData[indexPath.row].priority?.getColor()
        
        if(todolistData[indexPath.row].isCompleted){
            cell.isCompletedImage.image = UIImage(named: "Checked")
            cell.isCompletedImage.tintColor = UIColor.purple
        }
        else{
            cell.isCompletedImage.image = UIImage(named: "Unchecked")
            cell.isCompletedImage.tintColor = UIColor.gray
        }
        
                
        let tapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(toggleIsCompleted(sender:)))
        tapGestureRecognizer.task = todolistData[indexPath.row]
        cell.isCompletedImage.isUserInteractionEnabled = true
        cell.isCompletedImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    
    
    
}


class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var task: TaskDescription?
}

