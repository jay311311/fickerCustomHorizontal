//
//  ViewController.swift
//  fickerCustomHorizontal
//
//  Created by Jooeun Kim on 2022/12/13.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    // "1"로 표시되기 위한 index
    let initNum = 3
    let pickerList: [String] = ["●", "●", "●", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    let pickerMainText = pickerTextSetting(color: .purple, size: 30, weight: .bold)
    let pickerSideText = pickerTextSetting(color: .lightGray, size: 28, weight: .medium)

    lazy var pickerContainer = HorizontalPicker(dataList: pickerList, mainTextSetting: pickerMainText, sideTextSetting: pickerSideText, initNum: initNum).then {
        $0.clipsToBounds = true
    }

    lazy var labelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 5.0
    }

    lazy var questionTitle = UILabel().then { $0.text = "몇명을 초대할까요?" }
    lazy var unitCount = UILabel().then { $0.text = "명" }
    lazy var count = UILabel().then {
        $0.textColor = .systemPurple
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.text = pickerList[initNum]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindData()
        pickerContainer.setupPickerView(initNum)
        self.view.backgroundColor = .white
    }

    func setupLayout() {
        self.view.addSubview(labelStackView)
        self.view.addSubview(pickerContainer)

        pickerContainer.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        labelStackView.addArrangedSubview(questionTitle)
        labelStackView.addArrangedSubview(count)
        labelStackView.addArrangedSubview(unitCount)

        labelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
            $0.centerX.equalToSuperview()
        }
    }

    func bindData() {
        pickerContainer.indexRelay.subscribe(onNext: {
            self.count.text = $0
        }).disposed(by: disposeBag)
    }
}

