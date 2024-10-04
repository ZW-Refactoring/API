show databases;
use zerowaste;
drop table activity;

create table activity(
	actNo int not null auto_increment,
    actName varchar(100) not null,
    actCategory int not null,
    edate timestamp default current_timestamp,
	difficulty int,
    point int,
    constraint pk_activity primary key(actNo),
    constraint fk_actCtgr foreign key(actCategory) references activity_category(actCtgrNo)
);

drop table activity_category;
create table activity_category(
	actCtgrNo int primary key,
    actCtgrName varchar(30) not null
);

drop table activity_state_code;
create table activity_state_code(
	state_code int not null,
    state_name varchar(15) not null,
    
    constraint pk_state_code primary key(state_code)
);

drop table activity_state;
create table activity_state(
	stsno int not null auto_increment,
    username VARCHAR(255) NOT NULL,
    actNo int not null,
    state int ,
    sdate timestamp,
    edate timestamp,
    
    constraint pk_stsNo primary key(stsNo),
	constraint fk_actNo foreign key(actNo) references activity(actNo),
    constraint fk_username foreign key(username) references user(username)
);

set foreign_key_checks=0;
alter table activity_state add foreign key(state) references activity_state_code(state_code);

insert into activity_state_code(state_code, state_name) values(-1, '취소');
insert into activity_state_code(state_code, state_name) values(1, '진행중');
insert into activity_state_code(state_code, state_name) values(2, '인증완료');
insert into activity_state_code(state_code, state_name) values(3, '인증대기');
insert into activity_state_code(state_code, state_name) values(4, '인증반려');

insert into activity_state(userid, actNo, state, sdate) values(6, 1, 1, current_timestamp());
insert into activity_state(userid, actNo, state, sdate) values(6, 2, 1, current_timestamp());
insert into activity_state(userid, actNo, state, sdate) values(6, 3, 1, current_timestamp());
insert into activity_state(userid, actNo, state, sdate) values(6, 4, 1, current_timestamp());
select * from activity_state_code;
select * from activity_state;
select a.actno, a.actname, s.state, s.sdate, s.edate from activity_state s join activity a on s.actno = a.actno where username='kimjinho' order by s.actno, s.state ASC;
select a.actno, a.actname, s.state, c.state_name, s.sdate, s.edate from activity a, activity_state s, activity_state_code c where username='kimjinho' and a.actno=s.actno and  s.state=c.state_code order by s.actno, s.state ASC;
update activity_state set state = 2, edate = current_timestamp where actNo=3;
delete from activity_state where actNo = 1;

INSERT INTO activity(actName, actCategory, difficulty, point) values('중고거래하기', 20, 1, 100);
INSERT INTO activity(actName, actCategory, difficulty, point) values('텀블러 사용하기', 10, 1, 100);
INSERT INTO activity(actName, actCategory, difficulty, point) values('패트병 분리배출하기', 30, 1, 100);
INSERT INTO activity(actName, actCategory, difficulty, point) values('장바구니 사용하기', 10, 1, 100);
INSERT INTO activity(actName, actCategory, difficulty, point) values('중고서점 이용하기', 20, 1, 100);

INSERT INTO activity (actName, missionName, point) VALUES
(1, '재활용 가능한 보틀을 사용하여 물을 마시기', 200),
(2, '재사용 가능한 쇼핑백을 사용하여 장을 보기', 200),
(3, '식료품을 사러 갈 때 재사용 가능한 용기를 가져가기', 200),
(4, '물병, 금속 스트로, 식기 등을 재사용하기 위한 키트를 가지고 다니기', 200),
(5, '신선한 식재료를 재활용하여 식사 준비하기', 200),
(6, '개인용 용기를 가지고 식당에서 음식을 포장해가기', 200),
(7, '플라스틱 대신에 금속 빨대를 사용하기', 200),
(8, '음식물 쓰레기를 재활용하기 위한 컴포스트 바구니 사용하기', 200),
(9, '오프라인 쇼핑을 통해 온라인 포장재를 줄이기', 200),
(10, '재활용 가능한 제품을 선호하는 브랜드를 지원하기', 200),
(11, '주류를 구매할 때 유리병을 선택하기', 200),
(12, '텀블러를 사용하여 카페에서 음료 구매하기', 200),
(13, '지역 농장에서 생산된 제품을 구매하기', 200),
(14, '음식물을 버리지 않고 다른 요리에 활용하기', 200),
(15, '재활용 가능한 용기를 사용하여 자신의 간식을 가지고 다니기', 200),
(16, '옷을 기부하거나 재활용하기', 200),
(17, '배달음식 주문시 일회용 포크와 수저 제외하기', 200),
(18, '홈메이드 클리닝 제품을 사용하여 화학제품을 줄이기', 200),
(19, '홈메이드 화장품을 사용하여 포장재를 줄이기', 200),
(20, '정원에서 채소를 재배하여 자신의 음식을 만들기', 200),
(21, '사회적으로 책임있는 기업의 제품을 구매하기', 200),
(22, '가정에서 온실가스 배출을 줄이기 위해 전기 사용량을 줄이기', 200),
(23, '재활용 가능한 제품을 사용하여 세제를 구매하기', 200),
(24, '쇼핑 시 종이 대신에 전용 장바구니를 사용하기', 200),
(25, '전자 제품의 사용 수명을 연장하기 위해 유지보수하기', 200),
(26, '사용하지 않는 물건을 기부하거나 재활용하기', 200),
(27, '가정에서 폐기물을 분리 수거하여 재활용하기', 200),
(28, '재활용 가능한 용기를 사용하여 손 세정제를 구매하기', 200),
(29, '책을 전자 도서로 대체하여 종이 사용량을 줄이기', 200),
(30, '개인 용기를 가지고 캠프나 피크닉을 갈 때 음식을 가지고 가기', 200),
(31, '사용한 옷을 재활용하여 패션 액세서리 만들기', 200),
(32, '음식 쓰레기를 줄이기 위해 종이에 음식을 포장하기', 200),
(33, '인쇄물을 최소화하여 디지털 방식으로 문서를 공유하기', 200),
(34, '사용한 종이를 재활용하여 쇼핑 목록이나 노트를 만들기', 200),
(35, '홈메이드 생활용품을 사용하여 포장재를 줄이기', 200),
(36, '재활용 가능한 용기를 사용하여 가정에서 음료를 구매하기', 200),
(37, '홈메이드 세제를 사용하여 세탁물을 세탁하기', 200),
(38, '지역 커뮤니티에서 재활용하는 활동에 참여하기', 200),
(39, '사용하지 않는 옷을 판매하여 추가 수익을 얻기', 200),
(40, '자동차 대신 대중교통 활용하기', 200),
(41, '홈메이드 자연주의 제품을 사용하여 개인 위생을 유지하기', 200),
(42, '바다나 강가에서 쓰레기를 수거하기', 200),
(43, '가정에서 재활용할 수 있는 물건을 모아서 처리하기', 200),
(44, '생활에서 일회용 품목을 없애고 재사용 가능한 제품을 찾기', 200),
(45, '홈메이드 친환경 제품을 사용하여 가정에서 청소하기', 200),
(46, '가정에서 사용되는 물건을 손질하여 재활용하기', 200),
(47, '생활용품을 구매할 때 쓰레기를 줄이기 위해 홈메이드 제품을 찾기', 200),
(48, '가정에서 사용하는 생활용품을 재활용하기', 200),
(49, '재활용 가능한 제품을 사용하여 가정에서 생활 용품을 구매하기', 200),
(50, '홈메이드 친환경 제품을 사용하여 가정에서 청소하기', 200),
(51, '가정에서 사용되는 물건을 손질하여 재활용하기', 200),
(52, '친환경 설거지 비누 사용하기', 200),
(53, '친환경 수세미 사용하기', 200),
(54, '면 행주 사용하기', 200),
(55, '밀랍랩, 실리콘 뚜껑 사용하기', 200),
(56, '포장 용기 재활용하기', 200),
(57, '대나무 칫솔 사용하기', 200),
(58, '외출할 때 텀블러 챙기기', 200),
(59, '휴지, 물티슈 대신 손수건 사용하기', 200),
(60, '휴지 반으로 잘라 쓰기', 200),
(61, '대나무로 만든 휴지 사용하기', 200),
(62, '사탕수수로 만든 생분해되는 비닐을 사용하기', 200),
(63, '지퍼백 재사용하기', 200),
(64, '약병 버리지 않고 여행갈 때 화장품 담는 용도로 사용하기', 200),
(65, '잼이나 소스 등을 담았던 유리병을 깨끗이 씻어 재사용하기', 200),
(66, '일회용 랩 대신 실리콘 랩 사용하여 음식 보관하기', 200),
(67, '면 주머니를 활용하여 과일, 야채를 담기', 200),
(68, '소창수건 사용하기', 200),
(69, '소창행주 사용하기', 200),
(70, '플라스틱 제품 대신 스테인리스, 유리, 나무, 실리콘 재질의 물건 구입하기', 200),
(71, '사용하지 않는 전자제품 콘센트 뽑기', 200),
(72, '종이 영수증 대신 모바일 영수증 받기', 200),
(73, '필요없는 메일 삭제하기', 200),
(74, '사용하지 않는 이메일 계정 탈퇴하기', 200),
(75, '고기를 살 때 빈 통을 가지고 가서 고기 담아오기', 200),
(76, '야채를 살 때 비닐 대신 면 주머니 사용하기', 200),
(77, '일회용랩 대신 친환경 허니 랩 사용하기', 200),
(78, '일회용 지퍼백 대신 실리콘 지퍼백 사용하기', 200),
(79, '요리 그릇은 플라스틱 대신 스테인리스와 유리 사용하기', 200),
(80, '오래 쓴 플라스틱 통을 수납함으로 재활용하기', 200),
(81, '크라프트 종이봉투 사용하기', 200),
(82, '종이 박스를 재활용하여 잡동사니 보관하기', 200),
(83, '뽁뽁이 비닐 버리지 않고 재활용하기', 200),
(84, '빨래할 때 섬유 유연제 대신 건조기 드라이볼 사용하기', 200),
(85, '머리 감을 때 샴푸 바 사용하기', 200),
(86, '화학성분이 없는 천연 주방 비누 사용하기', 200),
(87, '분리배출할 때 재질별로 분리하고 깨끗이 세척하여 말려서 배출하기', 200),
(88, '홈메이드 음식 만들어 먹기', 200),
(89, '사용한 음식물을 활용하여 비료를 만들어 식물을 키우기', 200),
(90, '음식을 조리할 때 식자재를 먹을 수 있는 크기로 잘라서 남은 부분을 줄이기', 200),
(91, '가까운 거리는 걷거나 자전거 이용하기', 200),
(92, '사용하지 않는 물건을 판매하거나 기부하기', 200),
(93, '자신이 필요한 물건을 빌리거나 대여하여 사용하기', 200),
(94, '홈에서 소형 정원을 가꾸어 채소나 허브를 재배하기', 200),
(95, '소형 용기를 사용하여 가정에서 필요한 양의 화장품을 제작하기', 200),
(96, '에너지 효율적인 전구로 교체하여 전기 사용량을 줄이기', 200),
(97, '가정에서 사용하는 종이 제품 대신에 섬유 제품을 사용하기 (예: 천기저귀, 천냄비 스크러버 등)', 200),
(98, '지역 커뮤니티나 동네에서 주최하는 재활용 이벤트 참여하기', 200),
(99, '가전제품을 사용할 때 불필요한 에너지 소비를 줄이기 위해 절전 모드를 활용하기', 200),
(100, '물건을 구매할 때 환경 보호를 위해 사회적으로 책임 있는 기업의 제품을 선택하기', 200),
(101, '당근 거래 등 중고 거래 이용하기', 200),
(102, '중고서점에서 책 구입하기', 200),
(103, '음식물 쓰레기를 줄이기 위하여 냉장고 정리하기', 200),
(104, '에어캡(뽁뽁이)은 모아서 우체국에 갖다 주기', 200),
(105, '장보기 전에 구매할 물품 목록 쓰기', 200),
(106, '전단지 거절하기', 200),
(107, '음식물 쓰레기를 건조해서 일반쓰레기에 버리기', 200),
(108, '지역 농산물 구매하기', 200),
(109, '도서관 이용하기', 200),
(110, '채식 위주의 식단 먹기', 200),
(111, '원두 커피 구입하고 직접 갈기', 200),
(112, '제로웨이스트 쇼핑몰 방문하기', 200),
(113, '실내 식물 키우기', 200),
(114, '종이 통장 없는 계좌 활용하기', 200),
(115, '친환경 팜스테이 체험하기', 200),
(116, '직접 빵이나 요리 만들기', 200),
(117, '재활용품으로 미술 작품 만들기', 200),
(118, '건조기보다 빨래 건조대 사용하기', 200);

INSERT INTO activity_category values(10, '쓰지않기');
INSERT INTO activity_category values(20, '다시쓰기');
INSERT INTO activity_category values(30, '잘버리기');
INSERT INTO activity_category values(40, '제로샵이용');
INSERT INTO activity_category values(50, '테스트');

select a.actNo, a.actName, c.actCtgrName, a.edate, a.difficulty, a.point from activity a, activity_category c where a.actCategory = c.actCtgrNo order by a.actCategory;

select actCtgrName from activity_category;

select * from activity_category;

select * from(
 		select a.actNo, actName, c.actCtgrName actCategory, a.edate, a.difficulty, a.point from activity a, activity_category c where a.actCategory = c.actCtgrNo order by a.actCategory) allActivity
 		where actCategory = '다시쓰기';

delete from activity_state where state=2;

select  s.username, c.state_name, s.sdate, s.edate from
		activity a, activity_state s, activity_state_code c
		where a.actno=1 and s.state = c.state_code;