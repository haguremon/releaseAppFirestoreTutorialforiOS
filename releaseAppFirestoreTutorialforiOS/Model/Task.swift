//
//  Task.swift
//  releaseAppFirestoreTutorialforiOS
//
//  Created by IwasakIYuta on 2021/09/18.
//

import Foundation
import Firebase

class Task {
    let task: String?
    let creadeAt: Timestamp?
    let uid: String?
    let updatedAt: Timestamp?
    init(document: QueryDocumentSnapshot) {
        self.uid = document.documentID
        let dic = document.data()
        self.task = dic["task"] as? String
        self.creadeAt = dic["creadeAt"] as? Timestamp
        self.updatedAt = dic["updatedAt"] as? Timestamp
    }
    
}
