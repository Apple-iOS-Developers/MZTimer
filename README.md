# SharableTimer
WatchOS Sharable Timer Side project

### v1.0.0 기능 요구사항
- [x] 타이머를 잴 수 있는 이벤트를 Create Read Update Delete 할 수 있다.  
- [x] 이벤트 별 통계를 볼 수 있다.  
- [x] 이벤트 타이머가 끝나면 기록되고 정해진 번호로 문자가 전송된다(마치 운동처럼)  
- [x] 타이머 기능
- [x] 이벤트 공유기능(메시지)
- [x] 이벤트 iCalender에 기록 기능
- [x] 이벤트 기록, 공유 유무 설정 기능
- [x] 카테고리 기능(추가, 수정, 삭제, 통계)
- [x] 이벤트 기록 기능(수정, 삭제, 통계)
- [x] 친구 목록 기능(추가, 삭제)
- [x] 이벤트 엔드에서 캘린더에 직접 추가 기능
- [x] 이벤트 엔드에서 직접 친구에게 공유 기능
- [x] 앱 꺼지거나 중단되도 날짜 비교해서 카운터 resume 기능
- [x] 앱 설치 후 초기 실행시 세팅화면 통해 온보딩
- [ ] 기록 최소시간 설정 기능
- [ ] 워치와 연동되어 워치에서 이벤트 시작할 수 있는 기능
- [ ] 타이머 실행시킨 상황에서 background 진입이나 terminate 될때 로컬 push noti


### 레퍼런스 스크린샷 
- [Watch]  
<p float="left">
  <img src="https://user-images.githubusercontent.com/37135317/120066701-a4692d00-c0b2-11eb-9c8e-bec8044596ee.png" height="200" />
  <img src="https://user-images.githubusercontent.com/37135317/120066705-a7641d80-c0b2-11eb-8c98-eb3fed23c454.png" height="200" />
  <img src="https://user-images.githubusercontent.com/37135317/120066707-a9c67780-c0b2-11eb-8760-e3aedc321372.png" height="200" />
  <img src="https://user-images.githubusercontent.com/37135317/120066711-ac28d180-c0b2-11eb-89a7-2749ef14fb08.png" height="200" />
  <img src="https://user-images.githubusercontent.com/37135317/120066713-ae8b2b80-c0b2-11eb-93cf-4e40cde026fe.png" height="200" />
  <img src="https://user-images.githubusercontent.com/37135317/120066716-b1861c00-c0b2-11eb-8521-02440822e0f7.png" height="200" />
</p>

- [App]
<p float="left">
  <img src="https://user-images.githubusercontent.com/37135317/120066761-ef834000-c0b2-11eb-8763-296e5fc86aa9.png" height="600" />
  <img src="https://user-images.githubusercontent.com/37135317/120066762-f27e3080-c0b2-11eb-90a3-35a488b514d3.png" height="600" />
  <img src="https://user-images.githubusercontent.com/37135317/120066763-f4e08a80-c0b2-11eb-875c-ff7f20145424.png" height="600" />
</p>

---

### TODO list
[앱 할일]
- [x] app UI 홈 화면 구성
- [x] app UI Category end View 구성
- [x] 카테고리 추가 제거 구성
- [x] 받을 연락처 탭 추가해야함 (주소록에서 가져오게?)
- [x] 디바이스 저장기능추가
- [x] 카테고리 CRUD 기능 추가
- [x] 기록 엔드리스트뷰 추가 (무한 스크롤 페이징)
- [x] 저장된 이벤트들 통계 작업

[워치 할일]
- [x] 워치 타이머 UI 구성
- [x] 워치 타이머 기능 구성
- [x] 워치에서 타이머 끝나면 문자 보내지게 
- [x] 카테고리 워치에서 리스트 받아와서 뿌려주는 UI 구성
- [ ] 워치에서 타이머 끝나면 디바이스 저장되게

[부가기능]
- 카테고리 별로 보내는 연락처 따로 저장
- 보낼 상용구 커스텀 
- 기본 문자 내용
    ```
    xxx님이운동을 완료함
    실외걷기
    총거리(시간)
    ```
- 기간별 통계

### 저장해야될 내용
- [x] 이벤트 모델
- [x] 카테고리 모델
- [x] 보낼 연락처 모델

### 현재 이슈
- imessage 에서 여러명의 번호를 통해 메시지를 보내면 아이폰 유저 일 경우(imessage가 가능한 경우) 단체 메시지로 전송됨(단체 카톡처럼)
    - imessage 단체방에서는 서로간의 휴대폰 번호를 알 수 있음 (모르는 사람끼리 단체방이 만들어짐)
    - 현재 여러개 메시지를 imessage로 전송할때 개별로 보낼 수 있는 방법 없음ㅠ
- 타이머 1초마다 바뀐 시간을 표시하는데 ContentView 전체가 다시 그려지고 있다.
    - 원래 이런건가?

### 개선 사항
- combine 적용
- CoreData 적용

### 서버가 있다면
- [ ] 친구 추가된 사람만 주고 받을 수 있다.
- [ ] 개인 기록이 서버에 저장된다.
- [ ] 문자 메시지가 아니라 푸쉬 알람으로 전해진다.
- [ ] 경쟁 기능이 추가된다.
- [ ] 반응을 할 수 있게 된다.

### [작업 내역 및 계획](https://github.com/Apple-iOS-Developers/MZTimer/blob/main/%EC%9E%91%EC%97%85%EA%B3%84%ED%9A%8D%EC%9D%BC%EC%A7%80.md)
---

#### update 2021/06/12
- [x] 모든 기능 워치 없이 사용 가능하게 먼저 구현 후 워치 대응하자

#### update 2021/06/12
- 메시지를 받는 상대가 전부 iphone일 경우 imessage 그룹 메시지방이 만들어져서 사용자들 간에 연락처가 노출된다.

#### update 2021/06/13
- [x] 아니면 그냥 메시지 공유도 있는데 다른 SNS공유던가 icloud 캘린더에 기록하는건 어떨까??
- [x] 앞으로 한일을 기록도 있지만 실제로 한일을 icloud calendar를 통해서 할수 있을 거같은데
- [x] 카테고리 엔드뷰에서 카테고리 수정 기능 추가
- 기록 엔드리스트 달력있어도 좋을듯
- [x] 앱 종료되거나 백끄라운드 상태일때 앱 켜짐 꺼짐 시간 비교해서 타이머 재개시키는 기능 추가해야함(현재는 앱 백그라운드시 정지되고 종료되면 바로 기록되고 끝남)
- 캘린더 다시 전부 export 기능

#### update 2021/06/14
- 기록 최소 기록 최소 시간 세팅에 있으면 좋을듯

#### update 2021/07/04
- [x] 기록 마다 calendar export 기능 추가
- 기록 마다 공유기능 추가
- [x] 타이머 로직은 초단위가 아닌 시작 시간 끝시간으로 계산해서 앱 꺼지더라도 복구 가능하게 변경
    - idle 상태에서 background -> foreground [테스트완료]
    - idle 상태에서 terminated -> foreground [테스트완료]
    - 타이머 시작 상태에서 background -> foreground [테스트완료]
    - 타이머 시작 상태에서 terminated -> foreground [테스트완료]
    - 타이머 일시정지 상태에서 background -> foreground [테스트완료]
    - 타이머 일시정지 상태에서 terminated -> foreground [테스트완료]
    - 
- 푸쉬 노티 있으면 좋을 것 같음

#### update 2021/09/19
- 워치 life cycle 에 따라 stop, pause, resume 로직 점검해야함 (버그있음)
- 폰에서 또는 워치에서 타이머 실행하면 실시간으로 동기화 되도록 해야될거같은데 가능하려나
    - 불가능 하다면 따로 타이머 사용할 수 있도록 하고 앱켜질때 동기화
    - 동기화 정책은 어떻게?
        - 카테고리 무조건 (폰 -> 워치)
        - 연락처 무조건 (폰 -> 워치)
        - 이벤트 무조건 (워치 -> 폰): 워치에서 이벤트 기록 보지 않는다는 가정
- 워치에서 이벤트 끝난 뒤 기록보여주면서 메시지 공유할지 iCalender 기록 추가할지 버튼으로 물어보기(폰에서는 세팅에 따라 자동으로 됬지만 워치는 그떄그때 물어보자)
- 공유기능이 부족함 instagram share 추가하면 좋을듯
- 버그 리포트는 깃헙 이슈 api 연동해서 이슈 자동으로 만들어지도록?

#### update 2021/09/23
- emoji 입력값 확인 및 max len 1 제약 추가
- default emoji random generate
- emoji suggestion (like keyboard - if possible)
- 워치에서 캘린더 이벤트 생성불가 -> 폰으로 보내서 생성해야됨,,

---

### [v1.0.0 남은할일]
- [x] 워치 타이머) 워치 life cycle 에 따라 stop, pause, resume 로직 점검해야함 (버그있음)
- [x] 카테고리 생성시) emoji 입력값 확인 및 max len 1 제약 추가
- [x] 카테고리 생성시) default emoji random generate
- [x] 설정 화면) 기록 최소시간 설정 기능(default 5 secs)
- [x] 앱) 워치에서 타이머 끝나면 폰 앱에 저장되게
- [x] 워치) 워치에서 폰으로 끝난 이벤트 데이터 동기화
- [x] 공유하기) 기본 문자 내용 (한글?/영어?)
- [x] 앱) 타이머 실행시킨 상황에서 background 진입이나 terminate 될때 로컬 push noti
- [x] 공유하기) 공유기능이 부족함 instagram share 추가하면 좋을듯
- [x] 앱) 이벤트 엔드뷰에 share instagram story 추가
- [ ] VOC) 버그 리포트는 깃헙 이슈 api 연동해서 이슈 자동으로 만들어지도록?
- [ ] 공유하기) imessage 그룹으로 보내지는 문제 해결해야함


- 출시를 위한 기능부터 완성하자
1) 워치에서 타이머 기능
2) 워치에서 타이머 이벤트 폰이랑 연동

- 그 다음 버그나 UX개선하자
1) 메시지 작성
2) 설명 텍스트 관리

- 그 다음 추가기능 구현하자
1) 인스타 공유기능

[v2.0.0 예상할일]
- [ ] 카테고리 생성시) emoji suggestion (like keyboard - if possible)
- [ ] 앱) 타이머 끝나면 이벤트 엔드뷰로 push 되도록 수정
- [ ] 워치) 애플워치에서 타이머 실행될 때 폰에서도 동기화
- [ ] 기간별 통계(캘린더 뷰)
- [ ] 보낼 상용구 커스텀 
- [ ] Userdefaults -> CoreData
- [ ] StateObject, ObservedObject?
