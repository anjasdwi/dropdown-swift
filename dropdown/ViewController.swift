//
//  ViewController.swift
//  dropdown
//
//  Created by Anjas Dwi on 09/09/20.
//  Copyright © 2020 Anjas Dwi. All rights reserved.
//

import UIKit

class CellClass: UITableViewCell {
    
}
class ViewController: UIViewController {

    @IBOutlet weak var selectRole: UIButton!
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func addTransparentView(frame: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
        self.view.addSubview(tableView)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: CGFloat(self.dataSource.count * 50))
            
        }, completion: nil)
        
    }
    
    @objc func removeTransparentView() {
        let frame = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
            
        }, completion: nil)
    }
     
    @IBAction func showRoleOption(_ sender: Any) {
        selectedButton = selectRole
        dataSource = ["Manager", "HRD", "Admin", "Staff", "Engineer"]
        addTransparentView(frame: selectRole.frame)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
    
}
