//
//  ViewController.swift
//  CustomUITableViewProgrammatically
//
//  Created by Tran Ngoc Thanh on 5/2/18.
//  Copyright © 2018 Tran Ngoc Thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationItemTableViewCell
        cell.lblDateTime.text = "\(indexPath.row)"
        cell.lblSubject.text = "\(fruit[indexPath.row])"
        return cell
    }
    
    let myTableView = UITableView()
    let fruit: NSArray = ["apple", "orange", "banana", "strawberry", "lemon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // get width and height of View
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = 100.0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView.frame = CGRect(x: 0, y: barHeight+navigationBarHeight, width: displayWidth, height: displayHeight - (barHeight+navigationBarHeight))
        myTableView.register(NotificationItemTableViewCell.self, forCellReuseIdentifier: "cell")         // register cell name
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //Auto-set the UITableViewCells height (requires iOS8+)
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 44
        
//        self.view.addSubview(myTableView)
        
        let checkbox = UISwitch()
        self.view.addSubview(checkbox)
        let checkbutton = UIButton()
        self.view.addSubview(checkbutton)
        checkbutton.setTitleColor(.black, for: .selected)
        checkbutton.setTitle("checked", for: .selected)
        checkbutton.setTitle("disable", for: .disabled)
        checkbutton.setTitle("unckecked", for: .normal)
        checkbutton.isSelected = true
        checkbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: checkbutton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: checkbutton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        
//        checkbutton.isEnabled = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
class NotificationItemTableViewCell: UITableViewCell {
    let imgEmail = UIImageView()
    let lblDateTime = UILabel()
    let lblSubject = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgEmail.backgroundColor = .red
        imgEmail.translatesAutoresizingMaskIntoConstraints = false
        lblDateTime.translatesAutoresizingMaskIntoConstraints = false
        lblSubject.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgEmail)
        contentView.addSubview(lblSubject)
        contentView.addSubview(lblDateTime)
        
        let viewDist = [
            "image": imgEmail,
            "datetime": lblDateTime,
            "subject": lblSubject
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[datetime]-10-[subject]-20-|", options: [], metrics: nil, views: viewDist))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[image]-20-|", options: [], metrics: nil, views: viewDist))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-20-[datetime]-|", options: [], metrics: nil, views: viewDist))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-20-[subject]-|", options: [], metrics: nil, views: viewDist))
    }
    
    
}
