//
//  ViewController.swift
//  JJCPickerView
//
//  Created by gia-vt on 06/07/2019.
//  Copyright (c) 2019 gia-vt. All rights reserved.
//

import UIKit

import JJCPickerView

class ViewController: UIViewController {
    
    private var pickerView = JJCPickerView()
    private var selectedItem: JJCPickerItem?
    
    @IBOutlet weak var pickerButton: UIButton!
    
    @IBAction func onButtonClick(_ sender: Any) {
        self.pickerView.showPicker(at: self.view, withSelectedItem: self.selectedItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let height = self.view.bounds.height
        let frame = CGRect(x: 0,
                           y: height,
                           width: self.view.bounds.width,
                           height: height / 3)
        
        self.pickerView = JJCPickerView(frame: frame)
        self.pickerView.delegate = self
        
        self.pickerView.items = Array(0...15).map { JJCPickerItem(title: "Item \($0)", value: "\($0)") }
        
        self.view.addSubview(self.pickerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: JJCPickerViewDelegate {
    
    func onItemSelect(_ item: JJCPickerItem) {
        self.selectedItem = item
        
        self.pickerButton.setTitle(item.title, for: .normal)
    }
    
}
