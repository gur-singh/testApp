//
//  ViewController.swift
//  TestApp
//
//  Created by Gurpreet Singh on 01/11/18.
//  Copyright © 2018 Gurpreet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var hits = [Hits]()
    var isLoadMore = false
    var offset = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.register(UINib(nibName: "MyCellInfo", bundle: nil), forCellReuseIdentifier: "myCellInfo")
        hitApiForPosts(1)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var postsTableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func hitApiForPosts(_ offset:Int) {
        weak var weakSelf = self
        Api.sharedApi.GetApi(controller: self, extraVariable: nil, isPopViewController: nil, isHudShow: true, methodName: "", param: "\(offset)") { (json, status, error) in
            
            if status { //json received
                guard let json = json else {return}
                print(json)
                if let hitsArr = json["hits"] as? NSArray {
                    if hitsArr.count > 1 {
                        weakSelf?.offset += 1
                        weakSelf?.isLoadMore = true
                    }
                    else {
                        weakSelf?.isLoadMore = false
                    }
                    for case let hit as NSDictionary in hitsArr {
                        weakSelf?.hits.append(Hits(dictionary: hit))
                    }
                    
                    
                    
                 
                    DispatchQueue.main.async {
                        weakSelf?.navigationItem.title = "Total Posts are \(self.hits.count)"
                        weakSelf?.postsTableView.reloadData()
                    }
                }
                
            }
            else { // show errror
                if error != nil {
    let controller = UIAlertController(
                        title: "Error",
                        message: error,
                        preferredStyle: .alert)
                    
    let noAction = UIAlertAction(
                            title: "Ok",
                            style: .cancel,
                            handler: nil)
                        
                        controller.addAction(noAction)
                        
                    
                    weakSelf?.present(controller, animated: true, completion: nil)
                }
                }
              
            }
            
        }
    }

extension ViewController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore && indexPath.row == hits.count-1 {
            self.isLoadMore = false
            self.hitApiForPosts(offset)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellInfo", for: indexPath) as! MyCellInfo
        let model = hits[indexPath.row]
        cell.dateLabel.text = convertDateFormater(model.created_at)
        cell.titleLabel.text = model.title
        return cell
    }
    func convertDateFormater(_ dateCon: String?) -> String
    {
        guard let dateConvert = dateCon else {return "No date Found"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateConvert)
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
}

