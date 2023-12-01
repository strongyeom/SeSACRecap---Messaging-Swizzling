//
//  ViewController.swift
//  SeSACRecap
//
//  Created by 염성필 on 2023/12/01.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
}

// ViewWillAppear -> 런타임 시점 우리가 만든 methodSwizzling 실행
// 런타임 시점에서 바뀌는 것이기 때문에 오류 발생시 앱 꺼질 수 있음 📒 78회차 참고

extension UIViewController {
    // class vs static 차이 : 상속을 통한 오버라이드 유무
    //    class func methodSwizzling() {
    //
    //    }
    
    class func methodSwizzling() {
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        // ⭐️ 런타임 시점에서 전환됨
        // 첫번째 파라미터 해당 값이 어디에 있는지, 두번째 파라미터 기존 메서드 이름
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin),
              let changeMethod = class_getInstanceMethod(UIViewController.self, change)
        else {
            print("함수를 찾을 수 없습니다")
            return
        }
                
        method_exchangeImplementations(originMethod, changeMethod)
        
        
    }
    
    // viewWillAppear 를 만나면 changeViewWillAppear 메서드 실행
    @objc func changeViewWillAppear() {
        // 앱 분석 특정 기능
        print(#function)
    }
    
    
}
