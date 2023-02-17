//
//  ViewController.swift
//  Renda
//
//  Created by 木村美希 on 2023/02/18.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var tapButton: UIButton!
    var tapCount: Int = 0
    // Firestoreを扱うためのプロパティ
    let firestore = Firestore.firestore()
    
    // TAPボタンがタップされたときに
    @IBAction func tapTapButton( ) {
        // タップを数える変数にプラス1する
        tapCount += 1
        // タップされた数をLabelに反映する
        countLabel.text = String(tapCount)
        // FirestoreにtapCountを書き込む
        firestore.collection("counts").document("share").setData(["count": tapCount])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapButton.layer.cornerRadius = 125
        
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
            if error != nil {
                print("エラーが発生しました")
                print(error)
                return
            }
            let data = snapshot?.data()
            if data == nil {
                print("データがありません")
                return
            }
            let count = data!["count"] as? Int
            if count == nil {
                print("countという対応する値がありません")
                return
            }
            self.tapCount = count!
            self.countLabel.text = String(count!)
        }
    }
}
