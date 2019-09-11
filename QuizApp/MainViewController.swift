//
//  MainViewController.swift
//  QuizApp
//
//  Created by Trung Le on 9/11/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    var tableArray = [Any]()
    var json: JSON?
    var i = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.sv(tableView)
        
        
        Alamofire.request("http://0.0.0.0:8008/").responseJSON { response in  //Đây là khai báo closure. Closure khác gì một method, functioon bình thường
            print("json")
            switch response.result {
            case .success(let value):
                self.json = JSON(value)
                print("Number of records \(self.json!.count)")
                print("JSON: \(self.json![0])")
                
                for (_, record) in self.json! {
                    print(record["ID"])
                }
                self.tableView.reloadData()  //Reload lại tableview khi có dữ liệu mới
            case .failure(let error):
                print(error)
            }
        }
        
        setupData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.centerHorizontally().width(100%).top(0).bottom(0)
        tableView.register(MyCell.self, forCellReuseIdentifier: "quiz")
        tableView.separatorStyle = .none
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onRight))
        view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    @objc func onRight(){
        if i > 0 {
            i -= 1
            tableView.reloadData()
        }
    }
    @objc func onLeft(){
        if i < 4 {
            i += 1
            tableView.reloadData()
        }
    }
    func setupData(){
        tableArray.append(MyCell.init())
        tableArray.append(MyCell.init())
        tableArray.append(MyCell.init())
        tableArray.append(MyCell.init())
        tableArray.append(MyCell.init())
    }
    
}
extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.json == nil) {
            print("but json is nil")
            return 0
        } else {
            return self.json!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath) as? MyCell else {
            fatalError("fail")
        }
        var record: JSON =  self.json![i]
        
        switch indexPath.row {
        case 0:
            cell.label.text = record["Question"].stringValue
            cell.label.font = UIFont.boldSystemFont(ofSize: 28)
            cell.isUserInteractionEnabled = false
        case 1:
            cell.label.text = record["AnswerOne"].stringValue
        case 2:
            cell.label.text = record["AnswerTwo"].stringValue
        case 3:
            cell.label.text = record["AnswerThree"].stringValue
        default:
            cell.label.text = record["AnswerFour"].stringValue
            
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        default:
            return 60
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            if  self.json![i]["AnswerOne"].stringValue == self.json![i]["Result"].stringValue{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .green
            }else{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .red
            }
        case 2:
            if  self.json![i]["AnswerTwo"].stringValue == self.json![i]["Result"].stringValue{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .green
            }else{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .red
            }
        case 3:
            if  self.json![i]["AnswerThree"].stringValue == self.json![i]["Result"].stringValue{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .green
            }else{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .red
            }
        default:
            if  self.json![i]["AnswerFour"].stringValue == self.json![i]["Result"].stringValue{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .green
            }else{
                tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .red
            }
        }
        
    }
    
}
