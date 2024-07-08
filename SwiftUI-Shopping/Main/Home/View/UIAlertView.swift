//
//  UIAlertView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/8.
//

import UIKit

protocol UIAlertViewDelegate{
    
    func closeView()->Void
    
    func doneButtAc()->Void
    
}

class UIAlertView: UIView {


    var delegate:UIAlertViewDelegate?

    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var priceLab: UILabel!
    
    
    @IBOutlet weak var numLab: UILabel!
    
    
    
    @IBOutlet weak var butt: UIButton!
    
    @IBOutlet weak var salesLab: UILabel!
    
    override  func awakeFromNib() {
        
        super.awakeFromNib()
        initView()
        
    }
    
    func initView() -> Void {
        
        self.bgView.layer.cornerRadius = 20
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.butt.layer.cornerRadius = 20
        
    }
    
    @IBAction func subAc(_ sender: Any) {
        
        var num:Int = Int(numLab.text ?? "1")!
        
        if (num > 1){
            
            num -= 1
            
            numLab.text = String(num)
        }
    }
    
    @IBAction func addAc(_ sender: Any) {
        
        var num:Int = Int(numLab.text ?? "1")!
        
        num += 1
        
        numLab.text = String(num)
    }
    
    @IBAction func doneButtAc(_ sender: Any) {
        
        if delegate != nil{
            
            self.delegate?.doneButtAc()
        }
    }
    
    @IBAction func closeButtAc(_ sender: Any) {
        
        if delegate != nil{
            
            self.delegate?.closeView()
        }
    }
    
    func setDetailData(detail:GoodsDetailData) -> Void {
        
        priceLab.text = detail.goods_price_min
        salesLab.text = "库存\(detail.goods_sales)"
        
        imgView.sd_setImage(with: URL(string: detail.goods_images![0].preview_url))
    }
    
}
