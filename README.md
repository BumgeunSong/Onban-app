# 온반 Onban
> Food Shopping App

## 팀 & 개발 기간
- Eddy (iOS), Kai (iOS)
- 22.04.18 ~ 22.04.30

## 스크린샷
![image](https://user-images.githubusercontent.com/17468015/169211377-fc3f8d27-3574-4a98-a7a6-4a3eb34718c7.png)

## 기술적인 목표

* 재사용할 수 있는 네트워킹 모듈 설계
* 비동기 이미지 다운로드 및 캐싱
* MVVM 패턴 활용
* 테스터블한 코드 작성
* 단위 테스트 자동화
* 예외 처리 및 에러 모델링


## 학습 키워드
* MVVM, Observer Pattern, Property Observer
* CollectionView,  Compositional Layout, NSCache
* Alamofire, Protocol Extension
* Async Unit Test, Github Actions

## 고민과 해결
<details>
   <summary><h3>1. ViewController - ViewModel 역할 분리</h3></summary>
   
</details>
<details>
   <summary><h3>2. 커스텀 Observer 패턴 구현</h3></summary>
   
</details>
<details>
   <summary><h3>3. Collection View Section의 독립적인 로딩과, 이미지 비동기 로딩</h3></summary>
   
</details>
<details>
   <summary><h3>4. 재사용가능한 네트워킹 모듈 설계</h3></summary>
   
</details>
<details>
   <summary><h3>5. 협업을 위한 PR, 이슈, 리뷰 규칙</h3></summary>
   
</details>

## Team Rules
<details>
   <summary><h3>Branch</h3></summary>
   <ul>
      <li>`upstream/team-18`: 코드 리뷰 PR</li>
      <li>`origin/dev`: 팀 최종 브랜치</li>
      <li>`origin/feat-eddy`, `origin/feat-kai`: 작업용 브랜치</li>
   </ul>
</details>
<details>
   <summary><h3>Pull Request</h3></summary>
      <ul>
      <li>feat에 push한 후, dev로 PR 후 팀원끼리 리뷰. </li>
      <li>PR 시 github action에서 자동 build & test 통과해야만 merge 가능.</li>
      <li>코드 리뷰 시 dev에서 team-18로 PR</li>
   </ul>
</details>
<details>
   <summary><h3>Commit</h3></summary>
   <ul>
      <li>Commit에 Issue number 표기. ex. `[#4] Fix: something`  </li>
   </ul>
</details>
<details>
   <summary><h3>Issue</h3></summary>
   <ul>
      <li>기능 추가 시 Issue에 추가 후 넘버링</li>
      <li><strong>1분 이상</strong> 해결 못하는 에러 발생 시 Issue에 추가 후 공유</li>
   </ul>
</details>


## 설계
👉 [설계 문서 링크](https://drive.google.com/file/d/1ImYzNZKLs4mymOJdw64jbN_v6EGrE8OM/view)

![diagram](https://user-images.githubusercontent.com/17468015/164175553-ccf2a861-a0e6-4136-9a95-347da002cc28.png)
