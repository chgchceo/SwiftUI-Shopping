//
//  SwiftUIAlertView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/8.
//

import SwiftUI
import UIKit

struct SwiftUIAlertView: UIViewRepresentable, UIAlertViewDelegate {
    
    
    
    @State var detail:GoodsDetailData?
    @Binding var showView:Bool
    func closeView() {
        
        showView = false
    }
    
    func doneButtAc() {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        
        let view:UIAlertView = Bundle.main.loadNibNamed("UIAlertView", owner: self)?.last as! UIAlertView
        
        view.setDetailData(detail: self.detail!)
        view.delegate = self
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
        
    }
    
//    typealias UIViewType = UIKit.UIView
    
    
}
