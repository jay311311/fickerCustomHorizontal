//
//  PickerCountainer.swift
//  fickerCustomHorizontal
//
//  Created by Jooeun Kim on 2022/12/14.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

struct pickerTextSetting {
    var color: UIColor
    var size: CGFloat
    var weight: UIFont.Weight
}

class HorizontalPicker: UIView {
    let indexRelay = PublishRelay<String>()

    // 선택된 index 초기화
    var selectedNum: Int = 0
    var pickerList: [String]
    var mainTextSetting: pickerTextSetting
    var sideTextSetting: pickerTextSetting
    let initNum: Int

    // uiPicker뷰를 horizontal처럼 보이기 위해 90도 회전
    lazy var pickerView = UIPickerView().then { $0.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180)) }
    lazy var dividerTop = UIView().then { $0.backgroundColor = .systemGray6 }
    lazy var dividerBottom = UIView().then { $0.backgroundColor = .systemGray6 }

    init (dataList: [String], mainTextSetting: pickerTextSetting, sideTextSetting: pickerTextSetting, initNum: Int = 0) {
        self.pickerList = dataList
        self.mainTextSetting = mainTextSetting
        self.sideTextSetting = sideTextSetting
        self.initNum = initNum
        super.init(frame: .zero)
        pickerView.dataSource = self
        pickerView.delegate = self
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPickerView(_ initNum: Int) {
        selectedNum = initNum
        pickerView.selectRow(initNum, inComponent: 0, animated: false)
    }

    func setupLayout() {
        addSubview(pickerView)
        addSubview(dividerTop)
        addSubview(dividerBottom)
        
        // UIPicker뷰를 90도 돌렸기때문에 width와 heigt의 역할이 바뀌었다고 생각하면됨
        // UIPicker뷰의 wheel모양을 가리기위해 화면 면적보다 더 넒게 너비를 잡았다.
        pickerView.snp.makeConstraints {
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

extension HorizontalPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 투명한 회색 뷰 안보이게하기위함 : false로 변경시 picker뷰에서 선택 되었을때 보이는 뷰 안보이게함
        pickerView.subviews[1].isHidden = true

        let pickerLabel = UILabel()
        pickerLabel.text = pickerList[row]
        pickerLabel.textAlignment = NSTextAlignment.center
        
        // 90도 돌아간 uiPicker뷰의 Label을 -90도 돌려서 글자 예쁘게 보이게
        pickerLabel.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))

        if row == selectedNum {
            pickerLabel.font  = .systemFont(ofSize: mainTextSetting.size, weight: mainTextSetting.weight)
            pickerLabel.textColor = mainTextSetting.color
        } else {
            pickerLabel.font  = .systemFont(ofSize: sideTextSetting.size, weight: sideTextSetting.weight)
            pickerLabel.textColor = sideTextSetting.color
        }
        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNum = row
        if row >= initNum {
            indexRelay.accept(pickerList[row])
            pickerView.reloadComponent(component)
        } else {
            print("최소 1명 이상 선택해야합니당~~")
            indexRelay.accept("-")
            pickerView.reloadComponent(component)
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}



