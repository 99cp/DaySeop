# DaySeop

## 프로젝트 개요

### 프로젝트 설명

- 스마트폰을 추천해주는 [기존 프로젝트](https://github.com/99cp/choose_phone)에서 컴퓨터를 추천해주는 프로젝트로 확장
- 기존 프로젝트와 로직이 유사

## 기존 프로젝트에서 바뀐점

- 각 부품 웹 스크래핑
  - 메인보드, 램, GPU, CPU 웹 스크래핑 진행
    - 4번의 웹 스크래핑을 한번의 웹 스크래핑으로 합치고 싶었지만 실패함
- 성능 비교군
  - CPU는 캐시 메모리(L2)
  - GPU는 스트림 프로세서, 출력 단자의 개수
  - RAM은 시금치 램인지, RGB 램인지
  - 메인보드는 규격(ATX)
- 호환성 체크
  - 부품을 따로따로 추천해주는 방식이기에 호환성 체크가 필수적임
  - CPU, 메인보드 사이에서는 소켓
  - 메인보드, GPU 사이에서는 PCIE 버전
  - 메인보드, RAM 사이에서는 DDR 버전
- 각 부품마다의 설문지 작성 및 데이터 정렬

## 기술 스택

- Python
- JSP
- HTML & CSS
- Apache Tomcat
- PostgreSQL

## 담당 역할

- Python Selenium을 활용한 웹 스크래핑 및 데이터 정렬
- JSP, Tomcat을 이용한 웹-DB 통신 구현
- HTML을 통한 웹 데이터 표현
- PostgreSQL 데이터베이스 관리

## 개발 기간

- 2023.03.06 ~ 2023.06.20

## 문서화

- [작품 계획서](작품_계획서.pdf)
  - 작품 배경
  - 작품 주제
  - 시장 추세
  - 작품 목표
  - 실용적 근거
  - 기술 분석
  - 구현 환경
  - 추진 일정
  - 참고 문헌
