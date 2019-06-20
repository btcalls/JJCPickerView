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

public protocol JJCPickerViewDelegate: class {
    
    func onItemSelect(_ item:  JJCPickerItem)
    
}

public struct JJCPickerItem {
    public var title: String
    public var value: String
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

public class JJCPickerView: UIView {
    
    // MARK: Properties
    
    public weak var delegate: JJCPickerViewDelegate?
    
    public var distanceFromBottom: CGFloat = 0
    public var emptyListText: String = "No items set" {
        didSet {
            self.emptyListLabel.text = emptyListText
        }
    }
    public var items: [JJCPickerItem]! = [] {
        didSet {
            let hasItems = items.count > 0
            
            self.doneButton.isHidden = !hasItems
            self.emptyListLabel.isHidden = hasItems
            self.pickerView.isHidden = !hasItems
        }
    }
    fileprivate var bgView: UIView! = UIView()
    fileprivate var parentView: UIView! = UIView()
    fileprivate var selectedItem: JJCPickerItem?
    
    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var emptyListLabel: UILabel!
    @IBOutlet fileprivate weak var pickerView: UIPickerView! {
        didSet {
            pickerView.showsSelectionIndicator = true
        }
    }
    @IBOutlet fileprivate weak var doneButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func onCancelButtonSelection(_ sender: Any) {
        self.dismissPicker()
    }
    
    @IBAction func onDoneButtonSelection(_ sender: Any) {
        let item = self.selectedItem ?? self.items.first!
        
        self.delegate?.onItemSelect(item)
        self.dismissPicker()
    }
    
    // MARK: Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    // MARK: Private Methods
    
    private func commonInit() {
        let name = String(describing: JJCPickerView.self)
        let bundle = Bundle(for: JJCPickerView.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.clipsToBounds = false
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.emptyListLabel.text = self.emptyListText
        
        self.setupBGView()
    }
    
    private func setupBGView() {
        let size = UIScreen.main.bounds.size
        
        self.bgView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    // MARK: Public Methods
    
    public override func tintColorDidChange() {
        self.doneButton.tintColor = self.tintColor
    }
    
    public func dismissPicker() {
        self.togglePicker(direction: .down)
    }
    
    public func showPicker(at view: UIView, withSelectedItem item: JJCPickerItem? = nil) {
        self.parentView = view
        self.selectedItem = item
        
        self.togglePicker(direction: .up)
    }
    
    private func togglePicker(direction: Direction) {
        let size = UIScreen.main.bounds.size
        let height = self.contentView.frame.size.height + self.distanceFromBottom
        let width = self.contentView.frame.size.width
        let x = self.contentView.frame.origin.x
        let y = direction == .up ? size.height - height : size.height + height
                
        if direction == .up {
            self.bgView.alpha = 0
            
            self.parentView.insertSubview(self.bgView, belowSubview: self)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: x, y: y, width: width, height: height)
            
            if direction == .up {
                self.bgView.alpha = 1
            } else {
                self.bgView.alpha = 0
            }
        }) { (completed) in
            if direction == .down {
                self.bgView.removeFromSuperview()
            } else {
                if let item = self.selectedItem {
                    let index = self.items.firstIndex { $0.value == item.value }
                    
                    self.pickerView.selectRow(index!, inComponent: 0, animated: false)
                }
            }
        }
    }
    
}

extension JJCPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count
    }
    
}

extension JJCPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedItem = self.items[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        
        label.isOpaque = true
        label.numberOfLines = 2
        label.text = self.items[row].title
        label.textAlignment = .center
        
        return label
    }
    
}


