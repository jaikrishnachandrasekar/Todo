//
//  CreateTodoViewController.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import UIKit
import Alamofire

class CreateTodoViewController : UIViewController {
    
    var priority : Priority?;
    
    
    @IBOutlet weak var lblTaskName: UILabel!
    
    @IBOutlet weak var txtTaskName: UITextField!
    
    @IBOutlet weak var txtTags: UITextField!
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    @IBAction func prioritySegmentedControlActoin(_ sender: UISegmentedControl) {
        if(prioritySegmentedControl.selectedSegmentIndex == 0){
            priority = Priority.low
        }else if (prioritySegmentedControl.selectedSegmentIndex == 1){
            priority = Priority.medium
        }else{
            priority = Priority.high
        }
    }
    
    
    
    @IBAction func btnCreate(_ sender: UIButton) {
        createNewTodo(){(_) in
            DispatchQueue.main.async {
                
                
                let alert = UIAlertController(title: "Demo", message :"New Task Created Successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                    self.dismiss(animated: true, completion: nil)
                  //  (self.presentingViewController as! ViewController).todoTableView.reloadData();
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
  
    
    func createNewTodo(completion : @escaping (Bool) -> ()){
       
        let url = URL(string: "http://167.71.235.242:3000/todo")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters : [String : Any] = [
            "title" : (txtTaskName.text ?? "") ,
            "author" : "jai" ,
            "tag" : (txtTags.text ?? "" ) ,
            "is_completed" : false ,
            "priority" : (priority?.rawValue ?? "")
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpBody = jsonData;
    
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                    if let _ = data {
                       // DispatchQueue.main.async {
                            completion(true)
                       //                         }
                       
                        
                    }
        }.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        priority = Priority.low;
    }
    
}
