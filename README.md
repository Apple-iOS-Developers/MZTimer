# SharableTimer
WatchOS Sharable Timer Side project

### 기능 요구사항
- [x] 타이머를 잴 수 있는 이벤트를 Create Read Update Delete 할 수 있다.  
- [ ] 이벤트 별, 기간별 통계를 볼 수 있다.  
- [x] 이벤트 타이머가 끝나면 기록되고 정해진 번호로 문자가 전송된다(마치 운동처럼)  
- [x] 타이머 기능
- [x] 이벤트 공유기능(메시지)
- [x] 이벤트 iCalender에 기록 기능
- [x] 이벤트 기록, 공유 유무 설정 기능
- [x] 카테고리 기능(추가, 수정, 삭제, 통계)
- [x] 이벤트 기록 기능(수정, 삭제, 통계)
- [x] 친구 목록 기능(추가, 삭제)
- [ ] 기록 최소시간 설정 기능
- [ ] 이벤트 엔드에서 캘린더에 직접 추가 기능
- [ ] 이벤트 엔드에서 직접 친구에게 공유 기능
- [ ] 앱 꺼지거나 중단되도 날짜 비교해서 카운터 resume 기능
- [ ] 워치와 연동되어 워치에서 이벤트 시작할 수 있는 기능

문자 내용
```
xxx님이운동을 완료함
실외걷기
총거리(시간)
```

### 서버가 있다면
- [ ] 친구 추가된 사람만 주고 받을 수 있다.
- [ ] 개인 기록이 서버에 저장된다.
- [ ] 문자 메시지가 아니라 푸쉬 알람으로 전해진다.
- [ ] 경쟁 기능이 추가된다.
- [ ] 반응을 할 수 있게 된다.

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

### TODO list
[앱 할일]
- [x] app UI 홈 화면 구성
- [x] app UI Category end View 구성
- [x] 카테고리 추가 제거 구성
- [x] 받을 연락처 탭 추가해야함 (주소록에서 가져오게?)
- [x] 디바이스 저장기능추가
- [x] 카테고리 CRUD 기능 추가
- [x] 기록 엔드리스트뷰 추가 (무한 스크롤 페이징)
- [ ] 저장된 이벤트들 통계 작업

[워치 할일]
- [x] 워치 타이머 UI 구성
- [x] 워치 타이머 기능 구성
- [x] 워치에서 타이머 끝나면 문자 보내지게 
- [x] 카테고리 워치에서 리스트 받아와서 뿌려주는 UI 구성
- [ ] 워치에서 타이머 끝나면 디바이스 저장되게


[공통]
- [ ] 폰에서 워치로 데이터 동기화 기능
- [ ] 워치에서 폰으로 데이터 동기화 기능
- [ ] viewModel로 로직 정리


[순서]
공유 할 친구들 관련 기능 -> 카테고리 관련 기능 -> 최근기록 -> 워치 연동

[부가기능]
- 카테고리 별로 보내는 연락처 따로 저장
- 보낼 상용구 커스텀
- 

### 저장해야될 내용
- [x] 이벤트 모델
- [x] 카테고리 모델
- [x] 보낼 연락처 모델

### 디자인 패턴
- 전략패턴: section 별 더보기 버튼에 적용?

### 현재 이슈
- imessage 에서 여러명의 번호를 통해 메시지를 보내면 아이폰 유저 일 경우(imessage가 가능한 경우) 단체 메시지로 전송됨(단체 카톡처럼)
    - imessage 단체방에서는 서로간의 휴대폰 번호를 알 수 있음 (모르는 사람끼리 단체방이 만들어짐)
    - 현재 여러개 메시지를 imessage로 전송할때 개별로 보낼 수 있는 방법 없음ㅠ


### update 2021/06/12
- [x] 모든 기능 워치 없이 사용 가능하게 먼저 구현 후 워치 대응하자

### update 2021/06/12
- 메시지를 받는 상대가 전부 iphone일 경우 imessage 그룹 메시지방이 만들어져서 사용자들 간에 연락처가 노출된다.

### update 2021/06/13
- [x] 아니면 그냥 메시지 공유도 있는데 다른 SNS공유던가 icloud 캘린더에 기록하는건 어떨까??
- [x] 앞으로 한일을 기록도 있지만 실제로 한일을 icloud calendar를 통해서 할수 있을 거같은데
- [x] 카테고리 엔드뷰에서 카테고리 수정 기능 추가
- 기록 엔드리스트 달력있어도 좋을듯
- 앱 종료되거나 백끄라운드 상태일때 앱 켜짐 꺼짐 시간 비교해서 타이머 재개시키는 기능 추가해야함(현재는 앱 백그라운드시 정지되고 종료되면 바로 기록되고 끝남)
- 캘린더 다시 전부 export 기능

### update 2021/06/14
- 기록 최소 기록 최소 시간 세팅에 있으면 좋을듯

### update 2021/07/04
- 기록 마다 calendar export 기능 추가
- 기록 마다 공유기능 추가
- 타이머 로직은 초단위가 아닌 시작 시간 끝시간으로 계산해서 앱 꺼지더라도 복구 가능하게 변경
    - idle 상태에서 background -> foreground [테스트완료]
    - idle 상태에서 terminated -> foreground [테스트완료]
    - 타이머 시작 상태에서 background -> foreground [테스트완료]
    - 타이머 시작 상태에서 terminated -> foreground 
    - 타이머 일시정지 상태에서 background -> foreground [테스트완료]
    - 타이머 일시정지 상태에서 terminated -> foreground
    - 
- 푸쉬 노티

### update 2021/08/23
- [작업 내역 및 계획](https://github.com/Apple-iOS-Developers/MZTimer/blob/main/%EC%9E%91%EC%97%85%EA%B3%84%ED%9A%8D%EC%9D%BC%EC%A7%80.md)



