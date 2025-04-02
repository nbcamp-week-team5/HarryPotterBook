# HarryPotterBook
> 해리포터 책의 정보를 볼 수 있는 해리포터 시리즈 책 앱입니다.
<br>

## 📱 실행 화면
![Simulator Screen Recording - iPhone 16 Pro - 2025-04-02 at 11 52 11](https://github.com/user-attachments/assets/b8749dfb-c873-44ef-9f86-4fdadc98724a)
<br>

## 🛠️ 기술 스택

### 아키텍처
- MVC

### 데이터 처리
- UserDefaults

### 활용 API
- SwiftLint
- SnapKit

### UI Frameworks
- UIKit
- AutoLayout     
<br>

## 🔫 Trouble Shooting
- ScrollView 스크롤 오류
- 기타 AutoLayout 제약 조건 오류
- #selector 오류
- SummaryView 중복 생성 방지
- SeriesButtons 중복 생성 방지
- Series 여러개일 때 (Series 버튼 스택이 화면 width 초과 시) 대응
<br>

## 🗂️ 파일 구조
```
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Controllers
│   └── MainViewController.swift
├── Info.plist
├── Models
│   ├── Book.swift
│   └── DataService.swift
├── Resources
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   ├── Contents.json
│   │   ├── harrypotter1.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter1.jpg
│   │   ├── harrypotter2.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter2.jpg
│   │   ├── harrypotter3.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter3.jpg
│   │   ├── harrypotter4.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter4.jpg
│   │   ├── harrypotter5.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter5.jpg
│   │   ├── harrypotter6.imageset
│   │   │   ├── Contents.json
│   │   │   └── harrypotter6.jpg
│   │   └── harrypotter7.imageset
│   │       ├── Contents.json
│   │       └── harrypotter7.jpg
│   └── data.json
└── Views
    ├── BookInfoView.swift
    ├── ChaptersView.swift
    ├── DedicationView.swift
    ├── HeaderView.swift
    └── SummaryView.swift
```
