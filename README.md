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
   
<ul><li>고민
<ul><li>	MVC 패턴을 적용했을 때 ViewController가 과도하게 복잡해지는 것을 방지해보고 싶다는 마음에서 ViewModel을 사용해보기로 결정.
<li>	 테스트 가능한 부분을 더 넓혀보고 싶었음.
</li>
</li></ul>
</li></ul>
<p>  </p>
<ul><li> 배운 점
<ul><li>	 MVVM의 2가지 특징
<ul><li>		 1. 뷰의 상태를 추상화: 뷰 모델
<ul><li>			View는 시각적인 요소로만 구성이 되어있다. View에서는 레이아웃, 애니메이션, UI 컴포넌트 생성만 한다.
</li><li>			ViewModel은 View의 canonical한 상태를 나타낸다. View가 가져야할 ‘상태’의 기준이 된다. (Canonical Representation)
</li></ul></li></ul></li><li>		2. 바인딩
<ul><li>			ViewModel은 자기 자신이 가지는 상태를 UI 컴포넌트에 바인딩할 수 있도록 인터페이스를 제공한다.
<ul><li>			‘바인딩’이라는 테크닉을 사용해서, UI와 ViewModel을 연결한다.
</li><li>			우리는 View를 조작하지 않고, 그저 View Model의 비즈니스 로직을 조작하면, ViewModel의 상태가 바뀌거, 알아서 View도 업데이트된다.
</li><li>			뷰의 구현 로직을 몰라도 프레젠테이션 로직을 테스트할 수 있다.
</li></ul>
</li></ul>
</li></ul>
</li></ul>

<ul><li>	  MVVM의 단점
<ul><li>		  규모가 작은 앱에서는 과도하게 복잡하다. 더 많은 기능이 추가되고 유지보수가 중요해진다는 가정 하에 사용할 것 같다.
</li></ul></li><li>	  MVC != Massive View Controller
<ul><li>		  확실히 ViewModel을 쓰면 View Controller의 책임을 줄이는데 도움이 된다.
</li><li>		  하지만 반드시 MVVM을 써야하는가? MVVM을 쓰면 Massive View Controller가 다 해결되는가? 그건 아니다.
</li></ul></li><li>	  MVVM도 엄청 두꺼워질 수 있다.
<ul><li>		  단일 책임 원칙을 제대로 고려하지 않으면 거대한 ViewModel을 만드는 것도 얼마든지 가능하다.
</li><li>		  실제로 이번 프로젝트에서 같은 스크린에 등장하지만, 서로 책임이 다른 주문VM과 디테일정보VM은 분리할 수 있었다.
</li><li>		  VC가 지나치게 두꺼운 이유는 모델의 역할을 컨트롤러에 주기 때문일 수도 있다.
</li><li>		  비즈니스 로직은 여전히 VM이 아닌 모델이 다뤄야 한다. (비즈니스 로직과 아닌 것의 차이?)
</li></ul></li><li>	  MVC도 충분히 얇아질 수 있다.
<ul><li>		  ViewController를 여러개로 쪼개고 조합한다.
<ul><li>			  예를 들어, 헤더와 푸터를 별도의 뷰 컨트롤러로 분리한다든지.
</li><li>			  여러개의 뷰 컨트롤러를 포함한 Container ViewController를 만든다.
</li></ul></li><li>		  DataSource를 별도의 객체로 분리한다.
<ul><li>			  테이블 뷰, 컬렉션 뷰의 데이터 소스를 별도의 객체로 분리할 수 있다.
</li></ul></li></ul></li><li>		ViewController간 Routing 로직을 분리한다.
<ul><li>		    VC 간 이동과 데이터를 전달하는 로직을 따로 분리한다. 
</li><li>		    코디네이터라는 별도의 역할을 두기도 한다.
</li></ul></li><li>	    뷰 안에 프레젠테이션 로직을 분산시킨다.
<ul><li>		    뷰를 좀더 똑똑하게 만드는 방법이다.
</li></ul></li><li>	    MVVM의 진짜 장점
<ul><li>		    View에 대한 의존성이 전혀 없다는 것이다.
</li><li>		    테스터블
<ul><li>			    아주 쉽게 테스트를 할 수 있다. 
<ul><li>			    로직을 많이 바꿔도 테스트가 있기 때문에 안심할 수 있다.
</li></ul></li></ul></li><li>		    의존성을 한쪽 방향으로 일치시킬 수 있다. 
<ul><li>			    Observer pattern을 통해서 약하게 결합하기 때문이다. Clean Architecture와 궁합이 매우 좋다.
<ul><li>			    GUI 뿐만 아니라, 다른 Layer도 이렇게 의존성을 모두 Domain 로직으로만 향하게 해두면, 데이터의 흐름과 역할 분리가 매우 깔끔해진다. → Clean Architecture
</li><li>			    VC만 썼을 때에는 어떤 경우에는 View를 직접 조작하고, 어떤 경우에는 Model에서 알림을 받는 등. 의존하는 방향이 달라서 헷갈린다.
</li></ul>
</li></ul>
</li></ul>
</li></ul>


   
</details>
<details>
   <summary><h3>2. 커스텀 Observer 패턴 구현</h3></summary>
   
<ul><li><b>의사결정</b>
<ul><li>	Observable class를 직접 선언해서 viewModel에 필요한 데이터 바인딩을 구현
</li></ul></li><li><b>결정한 이유</b>
<ul><li>	KVO도 있지만 class를 써야하고 과도하게 복잡해보였음.
</li><li>	FRP도 있지만 아직 잘 모름.
</li></ul>
</li></ul>

   ```swift
final class Observable <T> {

    typealias Listener = (T?) -> Void

    var listener: Listener?

    var value: T? {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T? = nil) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
    }
}
 ```  
<ul><li><b>배운 점</b>
<ul><li>	Reference 타입이 필요한 경우: 변경가능한 값의 관찰
<ul><li>		<b>왜 Observable은 struct가 아니라 class여야할까?</b> 🔗  <a href="https://github.com/codesquad-members-2022/sidedish/pull/104#discussion_r857087471">질문</a> 
</li><li>		특정한 데이터의 값 변경을 <b>지속적으로 관찰하려면 해당 데이터가 '식별가능'해야하고</b>, 값이 바뀌었다고 해서 새로운 인스턴스가 되어서는 안됨. 따라서 '고유성'을 가지는 레퍼런스 타입이 적합.
</li><li>		(예전에 Notification Center에서 특정 객체를 관찰할 때도 똑같은 현상 발생)
</li></ul></li><li>	명령-쿼리의 분리
<ul><li>		Bind는 상태를 변경하는 명령임.
</li><li>		Bind와 동시에 값을 Return하면 디버깅을 하기가 어려워서 한참 동안 고생했음.
</li><li>		쿼리는 별도의 오퍼레이션으로 분리해야 예측가능한 코드를 만들 수 있음.
</li></ul>
</li></ul>
</li></ul>



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
