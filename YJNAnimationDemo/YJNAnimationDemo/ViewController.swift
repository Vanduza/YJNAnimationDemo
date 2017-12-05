//
//  ViewController.swift
//  YJNAnimationDemo
//
//  Created by YangJing on 2017/11/14.
//  Copyright © 2017年 YangJing. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var demoTitles:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        tableView.rowHeight = 40;
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        demoTitles = ["MatrixMenu","DripPageControl"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")!
        cell.textLabel?.text = demoTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let matrixVC = MatrixMenuDemoController.init(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(matrixVC, animated: true)
        }else if indexPath.row == 1 {
            let dripVC = DripControlViewController.init(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(dripVC, animated: true)
        }
    }
}

