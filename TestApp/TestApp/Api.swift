//
//  Api.swift
//  Parking Nexus Attendant
//
//  Created by dottechmac5 on 26/06/17.
//  Copyright © 2017 dottechmac5. All rights reserved.
//

import UIKit
import SystemConfiguration

class Api:UIViewController{
    let window = UIApplication.shared.keyWindow!
    
    static let projectName = ""
    class var sharedApi: Api
    {
        struct Static
        {
            static let instance: Api = Api()
        }
        return Static.instance
    }
    var activeVC = ""
    var UserDetails = NSDictionary()
    
    
    static let baseUrl = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page="
    
    
    
    
    
    
    
    
    func GetApi(controller: UIViewController,extraVariable:Any?,isPopViewController:Bool? ,isHudShow:Bool,methodName: String, param : String, completionClosure: @escaping (_ data: NSDictionary?,_ isStatus:Bool,_ err: String?)-> ())
    {
        print(param)
        let uRLStr :String =  "\(Api.baseUrl.appending(methodName))\(param)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(uRLStr)
        if isHudShow {
            showHud(controller.view)
        }
        print("Url is \(uRLStr)")
        let url = URL(string: uRLStr as String)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                if isHudShow {
                    self.DismissHud(controller.view)
                    
                }
            }
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                    
                    completionClosure(json,true,nil)
                    
                }catch let error as NSError{
                    completionClosure(nil,false,error.localizedDescription)
                    
                    print(error)
                }
            }
        }).resume()
        
    }
    
    func showHud(_ view:UIView) {
        iProgressHUD.sharedInstance().attachProgress(toView: view)
        view.showProgress()
    }
    
    func DismissHud(_ view:UIView) {
        view.dismissProgress()
    }
    
    
    
    
    
    
    
}
@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var shadowRadius: CGFloat = 2.0
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
