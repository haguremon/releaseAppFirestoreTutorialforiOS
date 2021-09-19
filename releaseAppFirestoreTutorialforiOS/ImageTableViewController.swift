//
//  ImageTableViewController.swift
//  releaseAppFirestoreTutorialforiOS
//
//  Created by IwasakIYuta on 2021/09/19.
//

import UIKit
import Firebase
import FirebaseStorage
class ImageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imagenameTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
        let storage = Storage.storage()

               // [2]ストレージへの参照を取得
        let storageRef = storage.reference(forURL: "gs://fir-intro-400a5.appspot.com")
        let imageRef = storageRef.child("image.jpg")
        let imageData = UIImage(named: "boy_11")!.jpegData(compressionQuality: 1.0)!
        imageRef.putData(imageData)
    }
    @IBAction func createButton(_ sender: Any) {
        guard let imagename = imagenameTextField.text else { return }
        print("kue-to")
        print(imagename)
        
        
    }
    
    @IBAction func readButton(_ sender: Any) {
        
        
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        guard let index = tableView.indexPathForSelectedRow,
              let newTask = imagenameTextField.text  else { return }
        print(index , newTask)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        
        
    }
    
    
    
    
    
    
}



extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.label.text = "test"
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.image.image = UIImage(named:"boy_11")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    
    
}
