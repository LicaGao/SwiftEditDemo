# SwiftEditDemo
### 11月24日练习
* tableView编辑练习 及左右侧划功能：
* 右划置顶：
```
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTop = UIContextualAction(style: .normal, title: "置顶") { (action, view, finished) in
            let first = IndexPath(row: 0, section: 0)
            tableView.moveRow(at: indexPath, to: first)
            finished(true)
        }
        actionTop.backgroundColor = UIColor.orange
        return UISwipeActionsConfiguration(actions: [actionTop])
    }
```
* 左划删除：
```
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "删除") { (action, view, finished) in
            self.ints.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            finished(true)
        }
        
        actionDel.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [actionDel])
    }
```
* 编辑：</br>需要先设置实现代理方法canEditRowAt，返回值为true，练习中因为需要移动cell所以也需要实现canMoveRowAt，并实现moveRowAt方法：
```
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = (sourceIndexPath as NSIndexPath).row
        let toRow = (destinationIndexPath as NSIndexPath).row
        let int = ints[fromRow]
        
        ints.remove(at: fromRow)
        ints.insert(int, at: toRow)
    }
```
