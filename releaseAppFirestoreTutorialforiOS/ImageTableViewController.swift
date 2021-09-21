//
//  ImageTableViewController.swift
//  releaseAppFirestoreTutorialforiOS
//
//  Created by IwasakIYuta on 2021/09/19.
//

import UIKit
import Firebase
import FirebaseStorage
import OrderedCollections
class ImageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imagenameTextField: UITextField!
    private let storage = Storage.storage()
    private var imagenames: OrderedSet<String> = []
    private var imagedates: [Data] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createImageDataAll()
        //uploadImageData(imagename: "boy_11")
    }
    //リリースアプリではここにカメラでのデータを取得してアップするようにする
    @IBAction func createButton(_ sender: Any) {
        guard let imagename = imagenameTextField.text else { return }
        uploadImageData(imagename: imagename)

    }
    
    @IBAction func readButton(_ sender: Any) {
        
        createImageDataAll()
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        guard let index = tableView.indexPathForSelectedRow,
              let newImage = imagenameTextField.text  else { return }
        print(index , newImage)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        
        
    }
    //MRAK: -FireBaseCRAD
    //全値の取得
    //storageRefを取得するメソッド
    private func  storageReferenceCreate() -> StorageReference {
        let storageRef = storage.reference(forURL: "gs://fir-intro-400a5.appspot.com/image.jpg")
        return storageRef
        
    }
    
    
    func createImageDataAll() {
        storageReferenceCreate().listAll { result, error in
            guard  error == nil else {
                print("error", error)
                return
                
            }
            result.items.forEach {self.imagenames.append($0.name)}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        storageReferenceCreate().child("images").getData(maxSize: 1 * 1024 * 1024) { data, error in
//            guard let data = data,
//                  error == nil else {
//                print("error", error)
//                return
//            }
//            self.imagedates.append(data)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//
        
    }
    
    
    
    
    
    //値の保存
    func uploadImageData(imagename: String) {
        
        let imageRef = storageReferenceCreate().child(imagename)
        guard let imageData = UIImage(named: imagename)?.jpegData(compressionQuality: 1.0) else {
            print("その画像は保存できません")
            return
        }
        //imageRef.putData(imageData)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        
        
        imageRef.putData(imageData, metadata: metadata) { _, error in
            if (error != nil) {
                print("upload error!")
                return
            } else {
                print("upload successful!")
                imageRef.downloadURL { url, error in
                    
                    if (error != nil) {
                        print("upload error!")
                        return
                    }
                    guard let downloadURL = url?.absoluteString else { return }
                    print(downloadURL)
                     
                }
                self.createImageDataAll()
                
            }
            
            
        }
        
        
        
    }
    
    //値を変更する
    func upDateImagesData(task: Task, newTask: String) {
        
        
        
    }
    
    //削除する機能
    func deleteImageData(task: Task) {
        
        
    }
    
    
    
    
    
    
    
    
}



extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imagenames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        let imagedate = imagedates[indexPath.row]
//        cell.label.text = imagedate.description
        let imagename = imagenames[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
//        cell.image.image = UIImage(data: imagedate)
       
        cell.image.image = UIImage(named: imagename)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    
    
}
