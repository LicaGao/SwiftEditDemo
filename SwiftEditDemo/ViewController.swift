//
//  ViewController.swift
//  SwiftEditDemo
//
//  Created by 高鑫 on 2017/11/24.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ints : [String] = ["一","二","三","四","五","六","七","八","九","十"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBAction func editItem(_ sender: UIBarButtonItem) {
        editAction()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func editAction() {
        if self.tableView.isEditing == false {
            self.tableView.setEditing(true, animated: true)
            self.editBtn.title = "完成"
        } else {
            self.tableView.setEditing(false, animated: true)
            self.editBtn.title = "编辑"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ints.count
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTop = UIContextualAction(style: .normal, title: "置顶") { (action, view, finished) in
            let first = IndexPath(row: 0, section: 0)
            tableView.moveRow(at: indexPath, to: first)
            finished(true)
        }
        actionTop.backgroundColor = UIColor.orange
        return UISwipeActionsConfiguration(actions: [actionTop])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "删除") { (action, view, finished) in
            self.ints.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            finished(true)
        }
        
        actionDel.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [actionDel])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let actionDel = UITableViewRowAction(style: .normal, title: "删除") { (_, indexPath) in
            self.ints.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        actionDel.backgroundColor = UIColor.red
        if tableView.isEditing == true {
            return [actionDel]
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = ints[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = (sourceIndexPath as NSIndexPath).row
        let toRow = (destinationIndexPath as NSIndexPath).row
        let int = ints[fromRow]
        
        ints.remove(at: fromRow)
        ints.insert(int, at: toRow)
    }
}

class TableViewCell: UITableViewCell {
    
}
