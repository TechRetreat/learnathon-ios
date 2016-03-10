//
//  DetailViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-08.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView: UIImageView? = self.view as? UIImageView
        if let prefSize = imageView?.image?.size {
            self.preferredContentSize = prefSize
        }
        
        self.title = "Golden Gate";
    }
}
