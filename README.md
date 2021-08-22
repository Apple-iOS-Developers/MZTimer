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
