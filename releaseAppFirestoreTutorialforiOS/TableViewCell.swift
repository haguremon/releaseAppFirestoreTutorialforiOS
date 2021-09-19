//
//  TableViewCell.swift
//  releaseAppFirestoreTutorialforiOS
//
//  Created by IwasakIYuta on 2021/09/19.
//

import UIKit

class TableViewCell: UITableViewCell {

    let label = UILabel()
    var image: UIImageView! = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        return image
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(label)
        addSubview(image)
        setViewSize()

    }
    private func setViewSize(){

        label.textAlignment = .center
        label.clipsToBounds = true
        label.frame.size = self.bounds.size
        image.frame.size.height = self.bounds.height - 10
        image.center = .init(x: self.bounds.minX + 13, y: self.bounds.height / 2)
        image.frame.size.width = self.bounds.width / 3

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame.size = self.bounds.size
//    }
}
