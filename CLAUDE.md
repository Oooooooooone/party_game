# 와글와글 (party_game)

플러터 수업 프로젝트. 여러 명이 방 코드로 모여 실시간으로 미니게임을 하는 앱.
매주 진행 내용을 교수님께 보고서로 제출함. 개발 기간 3주.

## 3주 범위 (확정, 더 추가하지 않음)
- 익명 로그인, 닉네임 입력
- 방 만들기 / 방 코드로 입장
- 대기실 (참가자 목록, 준비)
- 스피드 퀴즈 (서버시간 타이머, 점수, 결과 화면)
- 웹 배포
- 플랫폼: 폰 + 웹
- 시간 남으면: 대기실 채팅 → 방장 이탈 처리 → 캐치마인드(간단 버전)

## 주차별 계획
- 1주차: 개발 환경 세팅, Firebase 연결, 익명 로그인, 닉네임 입력
- 2주차: 방 만들기, 방 코드로 입장, 대기실
- 3주차: 스피드 퀴즈, 웹 배포, 시연

## 기술 스택
- Flutter
- Firebase Auth (익명 로그인)
- Cloud Firestore (실시간 데이터)
- Firebase Realtime Database (접속 끊김 감지, onDisconnect)
- Riverpod (상태 관리), go_router (화면 이동)
- Firebase Hosting (웹 배포)
- Cloud Functions는 유료라서 안 씀. 점수 계산은 방장 기기에서 처리

## Firestore 구조 초안
- rooms/{roomId}: code, hostId, gameType, status, phase, currentIndex, phaseEndAt
- rooms/{roomId}/players/{uid}: nickname, score, online
- rooms/{roomId}/answers/{문제번호_uid}: choice, answeredAt
- questions/{questionId}: text, choices, answer, category

## 설계 포인트
- 타이머는 기기 시계 말고 서버시간(serverTimestamp) 기준
- 답변 문서 ID를 문제번호_uid로 해서 중복 답변 방지
- 보안 규칙으로 남의 점수 수정 막기

## 작업 방식
- 나는 컴퓨터를 잘 못함. 쉽게 설명하고 한국어로 답할 것
- 내가 직접 해야 하는 일(로그인, 브라우저에서 설정, 비밀번호 입력 등)은 시작 전에 미리 알려줄 것
- 코드는 주석 없이, 너무 다듬지 않은 학생 스타일로
- 에러 나면 원인부터 짧게 설명하고 고칠 것
- 범위 밖 기능은 먼저 제안하지 말 것
- 커밋 메시지 형식: "N주차: 작업내용"
- 보고서 파일은 docs/ 폴더에 둠

## 주의할 점 (시연 대비)
- 퀴즈 문제는 2주차에 스크립트로 10~20개 미리 넣어두기
- 방장 이탈 처리는 안 만들 수도 있으니, 시연 때 방장은 노트북 웹으로 하기
- 타이머는 Realtime Database의 serverTimeOffset으로 보정하고, serverTimestamp가 null일 땐 계산 건너뛰기
- Firestore 테스트 모드는 30일 뒤 막힘. 시연 전에 보안 규칙 꼭 바꾸기
- 시연 2~3일 전에 배포 주소로 폰 2대 + 노트북 1대로 리허설
