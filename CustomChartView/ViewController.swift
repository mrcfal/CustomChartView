//
//  ViewController.swift
//  CustomChartView
//
//  Created by Marco Falanga on 21/09/18.
//  Copyright © 2018 Marco Falanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = CustomView(frame: view.frame)
        view.addSubview(customView)
    }


}

