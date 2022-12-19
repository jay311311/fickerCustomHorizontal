//
//  TablePicker.swift
//  fickerCustomHorizontal
//
//  Created by Jooeun Kim on 2022/12/19.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import WheelPicker


class CollectionPicker: UIView {

    let pickerList: [String]

    init(pickerList: [String]) {
        self.pickerList = pickerList
        super.init(frame: .zero)
        pickerView.dataSource = self
        pickerView.delegate = self
        setupLayout()
        pickerView.select(3, animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var pickerView = WheelPicker().then {
        $0.interitemSpacing = 25.0
        $0.style = .styleFlat
        $0.isMaskDisabled = true
        $0.scrollDirection = .horizontal
        $0.textColor = UIColor.systemGray5
        $0.highlightedTextColor = UIColor.purple
        $0.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        $0.highlightedFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    lazy var dividerTop = UIView().then { $0.backgroundColor = .systemGray6 }
    lazy var dividerBottom = UIView().then { $0.backgroundColor = .systemGray6 }
    func setupLayout() {
        addSubview(pickerView)
        addSubview(dividerTop)
        addSubview(dividerBottom)

        pickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
        dividerTop.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        dividerBottom.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}


extension CollectionPicker: WheelPickerDataSource, WheelPickerDelegate {
    func numberOfItems(_ wheelPicker: WheelPicker) -> Int {
        print(pickerList.count)
            return pickerList.count
    }
    func titleFor(_ wheelPicker: WheelPicker, at index: Int) -> String {
        return pickerList[index]
    }
    
    func wheelPicker(_ wheelPicker: WheelPicker, didSelectItemAt index: Int) {
              print("\(pickerList[index])")
      
    }
    
    func wheelPicker(_ wheelPicker: WheelPicker, marginForItem index: Int) -> CGSize {
        
        return CGSize(width: 3.0 , height: 0.0)
    }
    
}
