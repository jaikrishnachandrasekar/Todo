//
//  TabBarViewController.swift
//  Todo
//
//  Created by admin on 3/10/22.
//

import UIKit
import FittedSheets

class TabBarViewController: UITabBarController, UISearchResultsUpdating, UISearchControllerDelegate, UITabBarControllerDelegate, CreateTodoDelegate{

    
    @IBOutlet weak var tabNavigationItem: UINavigationItem!
    
    @IBAction func addNewClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CreateTodo", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "createTodo") as! CreateTodoViewController
        vc.delegate = self
        let sheetController = SheetViewController(controller: vc, sizes: [ .percent(0.5), .percent(0.75), .fullscreen])
        self.present(sheetController, animated: false, completion: nil)
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabNavigationItem.title = item.title;
    }
    
    func createdSuccess() {
        DispatchQueue.main.async {
        if(self.selectedViewController is TodoViewController){
            let todoController = self.selectedViewController as! TodoViewController
            todoController.todoViewModel.fetchTableData()
            
        }
        else if (self.selectedViewController is TagsViewController){
            let tagsController = self.selectedViewController as! TagsViewController
            tagsController.tagsViewModel.getTableData()
        }
     }
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        

            ApiController.instance.getTodoListData(searchString: text, limit: 1000){(data) in
             DispatchQueue.main.async {
                if(self.selectedViewController is TodoViewController){

                let todoController = self.selectedViewController as! TodoViewController
                  todoController.todoViewModel.todoListData = data;
                }
                else if(self.selectedViewController is TagsViewController){
                    let tagsController = self.selectedViewController as! TagsViewController
                
                    tagsController.tagsViewModel.groupedData = tagsController.tagsViewModel.dataToGroup(data: data);

                }
            }
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.searchTextField.autocapitalizationType = .none;
        self.navigationItem.searchController = searchController;
        
    }
    

 

}
