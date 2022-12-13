//
//  ViewController.swift
//  fickerCustomHorizontal
//
//  Created by Jooeun Kim on 2022/12/13.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    var selectedRow: Int = 3
    lazy var pickerContainer = UIView()
    
    lazy var testPicker = UIPickerView().then{
        $0.backgroundColor = .white
        $0.transform =  CGAffineTransform(rotationAngle: -90 * (.pi / 180))
    }
    
    let testPickerList:[String] = ["●", "●", "●", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        testPicker.dataSource = self
        testPicker.delegate = self
        testPicker.selectRow(3, inComponent: 0, animated: false)
    }
    
    func setupLayout(){
        self.view.addSubview(pickerContainer)
        pickerContainer.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(self.view.bounds.height / 2)
        }
        pickerContainer.addSubview(testPicker)
        testPicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testPickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // 불투명한 뷰 안보이게
        testPicker.subviews[1].isHidden = true
        
        let pickerLabel = UILabel()
        pickerLabel.text = testPickerList[row]
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.transform = CGAffineTransform(rotationAngle: 90  * (.pi/180))
        // 선택된 부분.과
        if row == selectedRow {
            pickerLabel.font = .systemFont(ofSize: 24, weight: .bold)
            pickerLabel.textColor = UIColor.purple
        }else{
            pickerLabel.font = .systemFont(ofSize: 18, weight: .medium)
            pickerLabel.textColor = UIColor.gray
        }
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        testPicker.reloadComponent(component)
    }
}



