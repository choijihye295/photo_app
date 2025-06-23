# 🎞️ life_photo_app : 네컷사진 만들기 

Flutter 기반의 네컷사진 프레임 앱입니다.  
사용자가 4장의 사진을 선택하여 네컷사진 스타일로 꾸밀 수 있습니다.

현재 원스토어에서 다운로드 받을 수 있습니다.
원스토어에 '네컷사진'을 검색해보세요.


---

## 📱 주요 기능

- PNG 프레임 선택
- PNG 프레임 위에 사진 4장 배치
- 사진 크기 조절 기능
- 결과물 공유 기능

---

## 🚀 사용법

1. 앱을 실행하고 프레임을 선택하세요.
2. 각 칸을 눌러 사진을 업로드하세요.
3. 사진 위치를 조절하거나 확대/축소할 수 있어요.
4. [공유] 버튼을 눌러 결과물을 공유하세요.

---

## 🛠️ 개발 환경

- Flutter 3.20.0
- Dart 3.8.0
- Android 지원

---

## 🛠️ 사용 패키지

- `image_picker` (v1.0.4)  
  기기에서 사진을 선택하거나 촬영할 수 있도록 지원합니다.

- `path_provider` (v2.1.2)  
  앱 내 파일 저장 위치(캐시, 문서 디렉토리 등)를 찾기 위해 사용합니다.

- `share_plus` (v7.2.1)  
  완성된 이미지를 외부 앱(카카오톡, 인스타 등)으로 공유할 수 있게 해줍니다.

- `permission_handler` (v11.0.0)  
  사진 접근, 저장 등 권한 요청을 관리합니다.

- `cupertino_icons` (v1.0.8)  
  iOS 스타일의 아이콘 사용을 위한 패키지입니다.

---

## 🛠️ 개발용 패키지 (개발/빌드에만 사용)

- `flutter_lints` (v5.0.0)  
  코드 스타일 검사 및 린팅 도구

- `flutter_launcher_icons` (v0.13.1)  
  앱 아이콘 자동 생성

- `flutter_native_splash` (v2.4.0)  
  앱 시작 시 표시되는 Splash 화면 설정 도구


---

## 🧾 코드 구조 및 설명

```plaintext
lib/
├── main.dart                         # 앱 진입점
└── screens/
    ├── FrameSelectionScreen.dart     # 프레임 선택 화면
    └── home_screen.dart              # 사진 편집(삽입/조절/공유) 메인 화면
``` 

### 📌 주요 파일 설명

- **main.dart**  
  앱의 시작점이며, `MaterialApp`을 통해 초기 화면을 설정합니다.  
  기본 라우팅 및 테마 설정이 이루어집니다.

- **screens/FrameSelectionScreen.dart**  
  사용자가 원하는 인생네컷 프레임 이미지를 선택하는 화면입니다.  
  선택된 프레임 경로를 `HomeScreen`으로 전달합니다.

- **screens/home_screen.dart**  
  선택한 프레임 위에 사진 4장을 배치하고 조정하는 기능을 담당하는 핵심 UI 화면입니다.  
  사진 선택, 확대/축소, 공유 기능이 구현되어 있습니다.

---

## 📸 스크린샷

![main_screen](assets/main.png)

---

## 📚 참고 자료

- [Flutter 공식 문서](https://docs.flutter.dev/)
- [Flutter Codelab](https://docs.flutter.dev/get-started/codelab)
