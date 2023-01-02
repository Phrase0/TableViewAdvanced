//
//  ViewController.swift
//  TableViewAdvanced
//
//  Created by Peiyun on 2023/1/2.
//

import UIKit

struct CellData{
    //記錄展開收合的情形
    var isOpen:Bool
    //設定顯示標題的資料
    var sectionTitle:String
    //記錄展開後要顯示的所有資料
    var sectionData:[String]
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    //建立一個等下準備存CellData的空陣列
    var tableViewData:[CellData] = []
    
    //有幾個Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    //每一個section有幾列
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].isOpen == true{
            //tableViewData[section].sectionData.count => sectionData的數量，加一是因為要加進標題
            return tableViewData[section].sectionData.count + 1
        }else{
            //只顯示標題
            return 1
        }
    }
    
    //每一筆資料的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //顯示標題
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
            //tableViewData[indexPath.section] => 點到的是第幾個section
            cell.textLabel?.text = tableViewData[indexPath.section].sectionTitle
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
            //sectionData[indexPath.row - 1] => 除了內容之外，前面還有個標題，故數量需減一
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    
    //選中後要做的事
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //如果點的是標題
        if indexPath.row == 0{
            if tableViewData[indexPath.section].isOpen == true{
                tableViewData[indexPath.section].isOpen = false
                //回去實作numberOfRowsInSection，秀出「每一個section有幾列」的方法
                //重新整理顯示資料(IndexSet)
                //integer:整數
                //indexPath.section => 有幾個section
                let indexes = IndexSet(integer: indexPath.section)
                //with: UITableView.RowAnimation => 要不要有動畫
                tableView.reloadSections(indexes, with: .automatic)
                
            }else{
                tableViewData[indexPath.section].isOpen = true
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
        
        //如果點的不是標題
        }else{
            //實作點進sectionData時要做的方法
            //以取消選取來舉例
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        tableViewData = [
            //每一個實體皆是一個section資料
            CellData(isOpen: false, sectionTitle: "Animals", sectionData: ["Cat","Dog","Rabbit","Elephant"]),
            CellData(isOpen: false, sectionTitle: "Colors", sectionData: ["Red","Green","Blue","Yello"]),
            CellData(isOpen: false, sectionTitle: "Fruits", sectionData: ["Banana","Apple","Mango","WaterMelon","Kiwi"]),
            CellData(isOpen: false, sectionTitle: "Numbers", sectionData: ["1","2","3","4","5","6","7"])]
    }


}

