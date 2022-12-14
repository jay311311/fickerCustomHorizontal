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
    // 1로 표시되기 위한 index
    let initNum = 3
    // 선택된 index
    var selectedNum = 3
    
    lazy var pickerContainer = UIView().then {
        $0.clipsToBounds = true
    }
    
    lazy var labelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 5.0
    }
    // uiPicker뷰를 horizontal처럼 보이기 위해 90도 회전
    lazy var testPicker = UIPickerView().then{ $0.transform =  CGAffineTransform(rotationAngle: -90 * (.pi / 180))}
    lazy var dividerTop = UIView().then{ $0.backgroundColor = .systemGray6 }
    lazy var dividerBottom = UIView().then{ $0.backgroundColor = .systemGray6 }
    
    lazy var questionTitle = UILabel().then { $0.text = "몇명을 초대할까요?" }
    lazy var unitCount = UILabel().then {  $0.text = "명" }
    lazy var count = UILabel().then {
        $0.textColor = .systemPurple
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.text = testPickerList[initNum]
    }
    
    let testPickerList:[String] = [ "●", "●", "●", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        self.view.backgroundColor = .white
        testPicker.dataSource = self
        testPicker.delegate = self
        testPicker.selectRow(initNum, inComponent: 0, animated: false)
    }
    
    func setupLayout(){
        self.view.addSubview(pickerContainer)
        self.view.addSubview(labelStackView)
       
        pickerContainer.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        pickerContainer.addSubview(testPicker)
        pickerContainer.addSubview(dividerTop)
        pickerContainer.addSubview(dividerBottom)

        labelStackView.addArrangedSubview(questionTitle)
        labelStackView.addArrangedSubview(count)
        labelStackView.addArrangedSubview(unitCount)
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
            $0.centerX.equalToSuperview()
        }
        // UIPicker뷰를 90도 돌렸기때문에 width와 heigt의 역할이 바뀌었다고 생각하면됨
        // UIPicker뷰의 wheel모양을 가리기위해 화면 면적보다 더 넒게 너비를 잡았다.
        testPicker.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.size.width * 2)
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


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testPickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // 투명한 회색 뷰 안보이게하기위함 : false로 변경시 picker뷰에서 선택 되었을때 보이는 뷰 안보이게함
        testPicker.subviews[1].isHidden = true
        
        let pickerLabel = UILabel()
        pickerLabel.text = testPickerList[row]
        pickerLabel.textAlignment = NSTextAlignment.center
        // 90도 돌아간 uiPicker뷰의 Label을 -90도 돌려서 글자 예쁘게 보이게
        pickerLabel.transform = CGAffineTransform(rotationAngle: 90  * (.pi/180))

        if row == selectedNum {
            pickerLabel.font = .systemFont(ofSize: 30, weight: .bold)
            pickerLabel.textColor = UIColor.purple
        }else{
            pickerLabel.font = .systemFont(ofSize: 28, weight: .medium)
            pickerLabel.textColor = UIColor.gray
        }
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row >= initNum {
            selectedNum = row
            count.text = testPickerList[row]
            testPicker.reloadComponent(component)
        } else {
            print("최소 1명 이상 선택해야합니당~~")
            testPicker.selectRow(initNum, inComponent: 0, animated: false)
            selectedNum = initNum
            count.text = testPickerList[initNum]
            testPicker.reloadComponent(component)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 65
    }
}



