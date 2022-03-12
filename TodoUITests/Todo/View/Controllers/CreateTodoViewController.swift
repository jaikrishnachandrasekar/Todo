//
//  CreateTodoViewController.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import UIKit
import Alamofire

protocol CreateTodoDelegate {
    func createdSuccess()
}

class CreateTodoViewController : UIViewController {
    
    var priority : Priority?;
     var delegate: CreateTodoDelegate?

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
        ApiController.instance.createNewTodo(title : txtTaskName.text ?? "" , tag : txtTags.text ?? "" , priority : priority?.rawValue ?? ""){(_) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Demo", message :"New Task Created Successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.createdSuccess()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priority = Priority.low;
    }
    
}
