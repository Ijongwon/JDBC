-- CRUD : 데이터의 생성,읽기,갱신,삭제를 가리키는 약자.
-- 프로그램이 가져야할 사용자 인터페이스(메뉴) 기본 기능.

-- 단순 조회 (read)
select * from TBL_STUDENT;

-- insert 테스트(create)
insert into Tbl_student values ('2023001','김땡땡',16,'경기도');

-- update 테스트
update TBL_STUDENT set age = 17, address = '종로구' where stuno = '2022011';

-- 삭제
delete from TBL_STUDENT where stuno = '2022011';

--여기서부터는 다른 테이블로 연습합니다
/*
1. 회원 로그인 - 간단히 회원아이디를 입력해서 존재하면 로그인 성공
2. 상품 목록 보기
3. 상품명으로 검색하기 (그외에 가격대 별 검색)
4. 상품 장바구니 담기 - 장바구니 테이블이 없으므로 구매를 원하는 상품을 List 에 담기
5. 상품 구매(결제)하기 - 장바구니의 데이터를 구매 테이블에 입력하기 (여러개 insert)
6. 나의 구매 내역 보기. 총 구매 금액을 출력해 주기
*/

select * from TBL_CUSTOM;
select * from TBL_product;
select * from TBL_product where pname like '%' || '동원' || '%';

select * from TBL_buy;		-- 구매 정보 테이블
select * from TBL_buy where customid='mina012';

create table j_custom as select * from tbl_custom;
select * from j_custom;

create table j_product as select * from tbl_product;
select * from j_product;

create table j_buy as select * from tbl_buy;
select * from j_buy;

-- pk,fk는 필요하면 제약조건을 추가합니다.
-- custom_id , pcode, buy_seq 컬럼으로 pk 설정하기
-- j_buy 테이블에는 외래키도 2개가 있습니다.(외래키 설정 제외하고 하겠습니다.)

alter table j_custom add constraint custom_pk primary key (custom_id);
alter table j_product add constraint product_pk primary key (pcode);
alter table j_buy add constraint buy_pk primary key (buy_seq);

insert into j_product values ('ZZZ01','B1','오뚜기바몬드카레',2400);
insert into j_product values ('APP11','A1','얼음골사과 1박스',32500);
insert into j_product values ('APP99','A1','씻은사과 10개',25000);

-- j_buy 테이블에 사용할 시퀀스
--시퀀스 삭제
drop sequence jbuy_seq;	
-- 적절한 시작값으로 다시 생성하기
create sequence jbuy_seq start with 1008;	
select jbuy_seq.nextval from dual;

-- rollback 테스트
select * from j_buy;
alter table j_buy add constraint q_check check (quantity between 1 and 30);
-- check 제약 조건 오류
insert into j_buy values (jbuy_seq.nextval,'twice','APP99',33,sysdate);			
		
-- 6. 마이페이지 구매내역
-- 2개 테이블 join하여 행 단위로 합계(수량*가격) 수식까지 조회
select buy_date, p.pcode , pname, quantity,price,quantity*price total from j_buy b 
join j_product p
on p.pcode=b.pcode
and b.customid='twice'
order by buy_date desc;  
--자주 사용될 join 결과는 view로 만들기. view는 create or replace 로 생성후에 수정까지 가능
-- view는 물리적인 테이블이 아닙니다. 물리적 테이블을 이용해서 만들어진 가상의 테이블(논리적 테이블)
create or replace view mypage_buy
as
select buy_date, customid, p.pcode , pname, quantity,price,quantity*price total from j_buy b 
join j_product p
on p.pcode=b.pcode
order by buy_date desc;  

select * from mypage_buy where customid='twice';

select sum(total) from mypage_buy where customid='twice';

select * from mypage_buy where customid='mina012';

select * from mypage_buy;


select * from member_tbl_02;

select * from money_tbl_02;

SELECT
  custno,
  custname,
  phone,
  address,
  TO_CHAR(joindate, 'YYYY-MM-DD'),
decode(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') as grade,
  city
FROM
  member_tbl_02;
  
select mt.custno,mt.custname,
decode(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') as grade,
	total
from member_tbl_02 mt
join(
	select custno, sum(price) as total
	from money_tbl_02
	group by custno 
	order by sum(price)
)  sale
on mt.custno = sale.custno;
  

-- 6월 19일 로그인 구현하기 위해 패스워드 칼럼 추가를 합니다.
-- 패스워드 컬럼은 해시값 64문자를 저장합니다.


alter table j_custom add password char(64);

-- twice 만 패스워드 값 저장하기
update j_custom set password = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'
where custom_id = 'twice';

select * from j_custom;
  
  