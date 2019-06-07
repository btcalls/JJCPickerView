//
//  JJCPickerView.swift
//  JJCPickerView
//
//  Created by Jason Jon E. Carreos on 07/06/2019.
//  Copyright © 2019 Jason Jon E. Carreos. All rights reserved.
//

import UIKit

private enum Direction {
    case up
    case down
}

protocol JJCPickerViewDelegate: class {
    
    func onItemSelect(_ item:  String)
    
}

class JJCPickerView: UIView {

    // MARK: Properties
    
    weak var delegate: JJCPickerViewDelegate?
    
    var items: [String]! = []
    
    private var selectedItem: String?
    private var parentView: UIView! = UIView()
    private var bgView: UIView! = UIView()
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: Actions
    
    @IBAction func onCancelButtonSelection(_ sender: Any) {
        self.dismissPicker()
    }
    
    @IBAction func onDoneButtonSelection(_ sender: Any) {
        if let delegate = self.delegate, let item = self.selectedItem {
            delegate.onItemSelect(item)
            self.dismissPicker()
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    // MARK: Private Methods
    
    private func commonInit() {
        let name = String(describing: JJCPickerView.self)
        
        Bundle.main.loadNibNamed(name, owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.clipsToBounds = false
        
        self.setupBGView()
    }
    
    private func setupBGView() {
        let size = UIScreen.main.bounds.size
        
        self.bgView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    // MARK: Public Methods
    
    func dismissPicker() {
        self.togglePicker(direction: .down)
    }
    
    func showPicker(at view: UIView) {
        self.parentView = view
        
        self.togglePicker(direction: .up)
    }
    
    private func togglePicker(direction: Direction) {
        let size = UIScreen.main.bounds.size
        let height = self.contentView.frame.size.height
        let width = self.contentView.frame.size.width
        let x = self.contentView.frame.origin.x
        let y = direction == .up ? size.height - height : size.height + height
        
        if direction == .up {
            self.bgView.alpha = 0
            
            self.parentView.insertSubview(self.bgView, belowSubview: self)
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.frame = CGRect(x: x, y: y, width: width, height: height)
            
            if direction == .up {
                self.bgView.alpha = 1
            } else {
                self.bgView.alpha = 0
            }
        }) { (completed) in
            if direction == .down {
                self.bgView.removeFromSuperview()
            }
        }
    }
    
}

extension JJCPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count
    }
    
}

extension JJCPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedItem = self.items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.isOpaque = true
        label.numberOfLines = 2
        label.text = self.items[row]
        label.textAlignment = .center
        
        return label
    }
    
}

