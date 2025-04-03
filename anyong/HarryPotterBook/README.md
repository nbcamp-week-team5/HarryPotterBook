## 📋 프로젝트 개요

ch3. 앱 개발 입문 주차 과제


## 👥 팀 구성

| 이름      | 역할       | GitHub                           |
| -------- | -------- | --------------------------------- |
| 최안용   | iOS 개발자 | [@ChoiAnYong](https://github.com/ChoiAnYong) |

---

## ⏰ 프로젝트 일정

- **시작일**: 25/03/24  
- **종료일**: 25/04/03

## 📱 트러블 슈팅
- UIButton(type: .system) 내장 UIImageView 잔상
- 버튼 클릭 시 background 색상을 변경하도록 했는데 UIButton 내부의 UIImageView에 변경 전 색상이 잔상으로 생기는 현상 발생
- background 설정시 UIImageView에도 영향을 주어 tintColor를 .clear 설정하여 해결
- 아직 완벽한 원인은 이해하지 못했습니다..

| 수정 전 | 수정 후 |
|:-:|:-:|
| <img src="https://github.com/user-attachments/assets/c9686210-0063-45f0-86c9-b723ca7e167c" width="180"/> | <img src="https://github.com/user-attachments/assets/6c59824e-6328-433a-b57e-a91be95f363a" width="180"/> |

- 수정 전 코드
```swift
        button.do {
            $0.setTitle("\(num)", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.setTitleColor(.white, for: [.selected, .disabled])
            
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
            
            $0.isSelected = num == 1 ? true : false
            $0.setTitle("\(num)", for: .normal)
            $0.backgroundColor = $0.isSelected ? .systemBlue : .systemGray5
            $0.addTarget(self, action: #selector(didTapOrderButton(_:)), for: .touchUpInside)
        }
```

- 수정 후 코드
```swift
        button.do {
            $0.setTitle("\(num)", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.setTitleColor(.white, for: [.selected, .disabled])
            $0.tintColor = .clear
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
            
            $0.isSelected = num == 1 ? true : false
            $0.setTitle("\(num)", for: .normal)
            $0.backgroundColor = $0.isSelected ? .systemBlue : .systemGray5
            $0.addTarget(self, action: #selector(didTapOrderButton(_:)), for: .touchUpInside)
        }
```
