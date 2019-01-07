//
//  PrefecturesPickerKeyboard.swift
//  weet
//
//  Created by owner on 2019/01/07.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class PrefecturesPickerKeyboard: UITextField {
    private var pickerView: UIPickerView!
    
    let prefecturesList: [String] = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                                     "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                                     "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                                     "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                                     "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                                     "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                                     "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    private func commoninit() {
        // datePickerの設定
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        setText()
        
        inputView = pickerView
        inputAccessoryView = createToolbar()
    }
    
    // キーボードのアクセサリービューを作成する
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        space.width = 12
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButtonItem = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(donePicker))
        
        let toolbarItems = [flexSpaceItem, doneButtonItem, space]
        
        toolbar.setItems(toolbarItems, animated: true)
        
        return toolbar
    }
    
    // キーボードの完了ボタンタップ時に呼ばれる
    @objc private func donePicker() {
        setText()
        resignFirstResponder()
    }
    
    // 性別をtextFieldにセットする
    @objc private func setText() {
        text = "\(prefecturesList[pickerView.selectedRow(inComponent: 0)])"
    }
    
    // コピペ等禁止
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    // 選択禁止
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    // カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
}

extension PrefecturesPickerKeyboard : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prefecturesList.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prefecturesList[row]
    }
    
}
