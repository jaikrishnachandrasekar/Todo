//
//  DataController.swift
//  Todo
//
//  Created by admin on 3/11/22.
//

import UIKit

class ApiController {
    
    static let instance = ApiController()

    func getTodoListData(searchString : String = "", limit : Int = 15 , completion : @escaping ([TaskDescription]) -> ()){
        var getTodoUrl  = "http://167.71.235.242:3000/todo?_page=1&_limit=\(limit)&author=jai"
        
        if(!searchString.isEmpty){
            getTodoUrl = getTodoUrl + "&tag=\(searchString)"
        }
        
        URLSession.shared.dataTask(with: URL(string: getTodoUrl)! ) { (data, urlResponse, error) in
                    if let data = data {
                        
                        let jsonDecoder = JSONDecoder()
                        
                        let taskDescription = try! jsonDecoder.decode(TodoDataList.self, from: data)
                        completion( taskDescription.data);
                    }
        }.resume()
        
    }
    
    func createNewTodo(title: String, tag : String, priority : String,  completion : @escaping (Bool) -> ()){
       
        let url = URL(string: "http://167.71.235.242:3000/todo")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters : [String : Any] = [
            "title" : title,
            "author" : "jai" ,
            "tag" : tag ,
            "is_completed" : false ,
            "priority" : priority
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpBody = jsonData;
    
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                    if let _ = data {
                            completion(true)
                    }
        }.resume()
        
    }
    
    func toggleCompleted(sender : CustomTapGestureRecognizer ,completion : @escaping (Bool) -> ()){
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
                        completion(true)
                    }
        }.resume()
        
    }
    
}
