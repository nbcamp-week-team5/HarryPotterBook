# HarryPotterBook

## 시행 영상
https://github.com/user-attachments/assets/3463ff73-1a1e-4804-80d7-de38ec991dd7

## 파일 구조
```
├── HarryPorterBook0324
│   ├── Data
│   │   └── Network
│   │       ├── DataService.swift
│   │       └── DataServiceProtocol.swift
│   ├── Domain
│   │   ├── Entities
│   │   │   ├── Book.swift
│   │   │   └── Chapter.swift
│   │   ├── Repositories
│   │   │   ├── SummaryRepository.swift
│   │   │   └── SummaryRepositoryProtocol.swift
│   │   ├── Service
│   │   │   ├── BookService.swift
│   │   │   ├── BookServiceProtocol.swift
│   │   │   ├── SummaryService.swift
│   │   │   └── SummaryServiceProtocol.swift
│   │   └── State
│   │       ├── PageState.swift
│   │       └── PageStateProtocol.swift
│   ├── Info.plist
│   ├── Presentation
│   │   ├── View
│   │   │   ├── BookInfoView.swift
│   │   │   ├── ChapterView.swift
│   │   │   ├── DedicationView.swift
│   │   │   ├── HeaderView.swift
│   │   │   ├── MainView.swift
│   │   │   ├── MainViewController.swift
│   │   │   └── SummaryView.swift
│   │   └── ViewModel
│   │       └── MainViewModel.swift
│   └── Support
│       ├── AppDelegate.swift
│       ├── Assets.xcassets
│       │   ├── AccentColor.colorset
│       │   │   └── Contents.json
│       │   ├── AppIcon.appiconset
│       │   │   └── Contents.json
│       │   ├── Contents.json
│       │   ├── harrypotter1.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter1.jpg
│       │   ├── harrypotter2.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter2.jpg
│       │   ├── harrypotter3.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter3.jpg
│       │   ├── harrypotter4.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter4.jpg
│       │   ├── harrypotter5.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter5.jpg
│       │   ├── harrypotter6.imageset
│       │   │   ├── Contents.json
│       │   │   └── harrypotter6.jpg
│       │   └── harrypotter7.imageset
│       │       ├── Contents.json
│       │       └── harrypotter7.jpg
│       ├── Base.lproj
│       │   └── LaunchScreen.storyboard
│       ├── SceneDelegate.swift
│       └── data.json
```

## 리팩토링 

### MainViewController에 전부 작성되어 있던 UI를 작은 컴포넌트 단위로 분리하기
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/8a0b8020fa872a921ff8b54eef0acd5c0c59ca5b
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/8c7f8df134d2e45ffa022cc71f3be6d49f20b860
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/9e56782198e0859fe158339cd6c2dd85ecc9a8c6
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/203aef452a650818c63495a8efbc5a48122a774d
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/c546974ad4c6b477b9f7fb3ab55a743c5ded7260

#### UI 구조
```
MainViewController
├── HeaderView
└── MainView
    ├── BookInfoView
    ├── DedicationView
    ├── SummaryView
    └── ChapterView
```

### Clean Architecture 구조를 참고해서 폴더 구조 변경해보기
참고 링크: https://github.com/kudoleh/iOS-Clean-Architecture-MVVM

#### 기존 구조 
```
HarryPorterBook
├── Model
├── Support
├── Service
└── View
```

#### 바꾼 구조 
```
BookHarryPorter
├── Data
│   └── Network
├── Domain
│   ├── Entities
│   ├── Repositories
│   ├── Service
│   └── State
├── Presentation
│   ├── View
│   └── ViewModel
└── Support
```

### ViewModel들 사이의 의존성 제거하기 
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/36609f715705e8848785fb36bf7fb5e7aa7632c0

### 의존성 주입을 적용하여 테스트 용이하게 만들기
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/e59a15ce8b50fe24b61e8d2cddc023ec6d2de887

### 오토레이아웃을 스냅킷으로 변경하기
https://github.com/nbcamp-week-team5/HarryPotterBook/commit/a45a0af841a8616216cf55f72851f33c36dfe136
