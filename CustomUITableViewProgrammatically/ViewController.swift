//
//  ViewController.swift
//  CustomUITableViewProgrammatically
//
//  Created by Tran Ngoc Thanh on 5/2/18.
//  Copyright © 2018 Tran Ngoc Thanh. All rights reserved.
//
import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    var mpVolumeView: MPVolumeView!
    var volumeSlider: UISlider!
    var volumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn: UIButton = UIButton(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 50))
        btn.setTitle("Volume View", for: UIControlState())
        btn.setTitleColor(UIColor.blue, for: UIControlState())
        btn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(ViewController.actionVolumPlus), for: UIControlEvents.touchUpInside);
        self.view.addSubview(btn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionVolumPlus() {
        if AVAudioSession.sharedInstance().isOtherAudioPlaying {
            do {
                try AVAudioSession.sharedInstance().setActive(false)
            } catch {
            }
        } else {
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
            }
        }
        
        if (mpVolumeView == nil) {
            volumeLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 30))
            volumeLabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(volumeLabel)
            
            mpVolumeView = MPVolumeView(frame: CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 30))
            self.view.addSubview(mpVolumeView)
            
            for view: UIView in mpVolumeView.subviews {
                if (NSStringFromClass(view.classForCoder) == "MPVolumeSlider") {
                    volumeSlider = view as! UISlider;
                    volumeSlider.sendActions(for: .touchUpInside)
                    volumeSlider.addTarget(self, action: #selector(ViewController.actionSliderChanged(_:)), for: UIControlEvents.allTouchEvents)
                    
                    volumeLabel.text = "\(volumeSlider.value)"
                }
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.volumeChanged(_:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        }
    }
    
    @objc func actionSliderChanged(_ sender: UISlider) {
        volumeLabel.text = "\(volumeSlider.value)"
    }
    
    @objc func volumeChanged(_ notification: Notification) {
        print(notification)
        let userInfo: Dictionary = notification.userInfo! as Dictionary
        print(userInfo)
        print(userInfo.keys)
        print(userInfo.values)
    }
}
import UIKit
import MediaPlayer

//class ViewController: UIViewController, UITableViewDataSource {
//    let heightCell: CGFloat = 50.0
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fruit.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationItemTableViewCell
//        cell.lblDateTime.text = "\(indexPath.row)"
//        cell.lblSubject.text = "\(fruit[indexPath.row])"
//        return cell
//    }
//
//    let myTableView = UITableView()
//    let fruit: NSArray = ["apple", "orange", "banana", "strawberry", "lemon"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
////        initialTableView()
////        initialNavigationBar()
//        iniialMPvolumeView()
//    }
//    func iniialMPvolumeView() {
//    }
//    func initialNavigationBar() {
//        let uivNav = UINavigationBar()
//        let uivMain = UIView()
//        view.addSubview(uivMain)
//        uivMain.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            uivMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
//            uivMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            uivMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            uivMain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
//            ])
//        uivMain.layer.borderWidth = 1
//        uivMain.layer.borderColor = UIColor.lightGray.cgColor
//        uivMain.addSubview(uivNav)
//        uivNav.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            uivNav.centerYAnchor.constraint(equalTo: uivMain.centerYAnchor, constant: 0.0),
//            uivNav.centerXAnchor.constraint(equalTo: uivNav.centerXAnchor, constant: 0.0),
//            uivNav.widthAnchor.constraint(equalTo: uivMain.widthAnchor, multiplier: 1.0),
//            uivNav.heightAnchor.constraint(equalToConstant: 44)
//            ])
//        uivNav.layer.borderWidth = 1
//        uivNav.layer.borderColor = UIColor.black.cgColor
//        let btnTop = UIButton()
//        let btnLast = UIButton()
//        let tbrMid = UITabBar()
//        uivNav.addSubview(btnTop)
//        uivNav.addSubview(tbrMid)
//        uivNav.addSubview(btnLast)
//
//    }
//    func initialTableView() {
//        let uivMain = UIView()
//        view.addSubview(uivMain)
//        uivMain.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            uivMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
//            uivMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            uivMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            uivMain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
//            ])
//        uivMain.layer.borderWidth = 1
//        uivMain.layer.borderColor = UIColor.lightGray.cgColor
//
//        uivMain.addSubview(myTableView)
//        myTableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            myTableView.centerXAnchor.constraint(equalTo: uivMain.centerXAnchor, constant: 0.0),
//            myTableView.centerYAnchor.constraint(equalTo: uivMain.centerYAnchor, constant: 0 - heightCell),
//            myTableView.widthAnchor.constraint(equalTo: uivMain.widthAnchor, multiplier: 5/6),
//            myTableView.heightAnchor.constraint(equalToConstant: heightCell*5)])
//        myTableView.layer.borderColor = UIColor.lightGray.cgColor
//        myTableView.layer.borderWidth = 1
//        myTableView.register(NotificationItemTableViewCell.self, forCellReuseIdentifier: "cell")   // register cell name
//
//        myTableView.dataSource = self
//        myTableView.delegate = self
//        //Auto-set the UITableViewCells height (requires iOS8+)
//        myTableView.rowHeight = UITableViewAutomaticDimension
//        myTableView.estimatedRowHeight = heightCell
//
//        let uivHeaderSecurityArea = UIView()
//        uivMain.addSubview(uivHeaderSecurityArea)
//        uivHeaderSecurityArea.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            uivHeaderSecurityArea.centerXAnchor.constraint(equalTo: myTableView.centerXAnchor, constant: 0.0),
//            uivHeaderSecurityArea.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: 1.0),
//            uivHeaderSecurityArea.widthAnchor.constraint(equalTo: myTableView.widthAnchor, multiplier: 1.0),
//            uivHeaderSecurityArea.heightAnchor.constraint(equalToConstant: heightCell)])
//        uivHeaderSecurityArea.layer.borderColor = UIColor.lightGray.cgColor
//        uivHeaderSecurityArea.layer.borderWidth = 1
////        let lblHeaderAreaName = UILabel()
//
////        let uivInputPass = UIView
//        let btnCancel = UIButton()
//        uivMain.addSubview(btnCancel)
//        btnCancel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            btnCancel.widthAnchor.constraint(equalToConstant: 250.0),
//            btnCancel.heightAnchor.constraint(equalToConstant: 50.0),
//            btnCancel.topAnchor.constraint(equalTo: myTableView.bottomAnchor, constant: myTableView.frame.height/2),
//            btnCancel.trailingAnchor.constraint(equalTo: uivMain.centerXAnchor, constant: 0 - heightCell)])
//        btnCancel.backgroundColor = .black
//        btnCancel.setTitle("Cancel", for: .normal)
//        let btnStart = UIButton()
//        uivMain.addSubview(btnStart)
//        btnStart.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            btnStart.widthAnchor.constraint(equalToConstant: 250.0),
//            btnStart.heightAnchor.constraint(equalToConstant: 50.0),
//            btnStart.bottomAnchor.constraintEqualToSystemSpacingBelow(uivMain.bottomAnchor, multiplier: -1/2),
//            btnStart.leadingAnchor.constraint(equalTo: uivMain.centerXAnchor, constant: heightCell)])
////        btnStart.backgroundColor = .black
//        btnStart.layer.borderWidth = 1
//        btnStart.layer.borderColor = UIColor.lightGray.cgColor
//        btnStart.setTitle("Start", for: .normal)
//        if(true) {
//            let lblmsg = UILabel()
//            uivMain.addSubview(lblmsg)
//            lblmsg.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                lblmsg.centerXAnchor.constraint(equalTo: myTableView.centerXAnchor, constant: 0.0),
//                lblmsg.topAnchor.constraint(equalTo: myTableView.bottomAnchor, constant: 0.0),
//                lblmsg.widthAnchor.constraint(equalTo: myTableView.widthAnchor, multiplier: 1.0),
//                lblmsg.heightAnchor.constraint(equalToConstant: heightCell)])
//            lblmsg.text = "qwertyuiopasdfghjklwertyuioghjkasdfghjklsdfghjksdfghj"
//            lblmsg.textAlignment = NSTextAlignment.center
//            lblmsg.font = UIFont.systemFont(ofSize: 22.0)
////            lblmsg.layer.borderColor = UIColor.lightGray.cgColor
////            lblmsg.layer.borderWidth = 1
//            let lblPin = UILabel()
//            uivMain.addSubview(lblPin)
//            lblPin.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                lblPin.trailingAnchor.constraint(equalTo: uivMain.centerXAnchor, constant: -20.0),
//                lblPin.leadingAnchor.constraint(equalTo: lblmsg.leadingAnchor, constant: 0.0),
//                lblPin.topAnchor.constraint(equalTo: lblmsg.bottomAnchor, constant: 0.0),
//                lblPin.heightAnchor.constraint(equalToConstant: heightCell)])
//            lblPin.text = "qwerty"
//            lblPin.textAlignment = NSTextAlignment.center
//            lblPin.font = UIFont.systemFont(ofSize: 22.0)
//
//        }
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func initialCheckButton() {
//        let checkbox = UISwitch()
//        self.view.addSubview(checkbox)
//        let checkbutton = UIButton()
//        self.view.addSubview(checkbutton)
//        checkbutton.setTitleColor(.black, for: .selected)
//        checkbutton.setTitle("checked", for: .selected)
//        checkbutton.setTitle("disable", for: .disabled)
//        checkbutton.setTitle("unckecked", for: .normal)
//        checkbutton.isSelected = true
//        checkbutton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint(item: checkbutton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
//        NSLayoutConstraint(item: checkbutton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
//    }
//
//}
//extension ViewController:UITableViewDelegate{
//
//}
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
        
//        contentView.addSubview(imgEmail)
        contentView.addSubview(lblSubject)
        contentView.addSubview(lblDateTime)
        
        let viewDist = [
            "image": imgEmail,
            "datetime": lblDateTime,
            "subject": lblSubject
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[datetime]-10-[subject]-20-|", options: [], metrics: nil, views: viewDist))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[image]-20-|", options: [], metrics: nil, views: viewDist))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-20-[datetime]-|", options: [], metrics: nil, views: viewDist))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(50)]-20-[subject]-|", options: [], metrics: nil, views: viewDist))
    }
}
