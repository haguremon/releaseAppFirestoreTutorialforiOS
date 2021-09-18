//
//  ViewController.swift
//  releaseAppFirestoreTutorialforiOS
//
//  Created by IwasakIYuta on 2021/09/16.
//

import UIKit
import Firebase
import PKHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    var db = Firestore.firestore()
    
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //db.collection("test").addDocument(data: ["int":456, "string": "文字列"])
        createTasksDataAll()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    @IBAction func createButton(_ sender: Any) {
        guard let task = taskTextField.text else { return }
        print("kue-to")
        newTaskData(task: task)
        
        
    }
    
    @IBAction func readButton(_ sender: Any) {
        
        createTasksDataAll()
        
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
        print(tasks)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        
        
    }
    
    
    //MRAK: -FireBaseCRAD
    //全値の取得
    func createTasksDataAll() {
        //ここでorder(by: "task", descending: true)で作成順に作成する
        db.collection("tasks").order(by: "task", descending: true).getDocuments { [ weak self] querySnapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            self?.tasks = (querySnapshot?.documents.map({ queryDocumentSnapshot -> Task in
                let task = Task(document: queryDocumentSnapshot)
                
                return task
            }))!
            
            DispatchQueue.main.async {
            
                self?.tableView.reloadData()
            }

        }
        

    }
        
        
        
        
        
        //値の保存
        func newTaskData(task: String) {
            
            let documentData = ["task": task, "createdAt": Timestamp(), "updatedAt": Timestamp()] as [String : Any]
            
            db.collection("tasks").document().setData(documentData) { error in
                
                if let error = error {
                    print("error: \(error))")
                    return
                }
                
                
            }
            
            
        }
        
        //値を変更する
        func upDateTasksData(task: Task, newTask: String) {
    
            
        
        }
        
        
        //削除する機能
        func deleteTasksData(task: Task) {
            
            
            
        }
        
        
        
        
    }



    //MARK: -extension ViewController
  
    
    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            return tasks.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
 
            
            cell.textLabel?.text = tasks[indexPath.row].task
            
            return cell
        }
        
        
        
        
    }
