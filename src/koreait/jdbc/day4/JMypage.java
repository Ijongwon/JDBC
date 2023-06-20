package koreait.jdbc.day4;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;


@Getter
@AllArgsConstructor
@Builder
public class JMypage {
	private Date buy_date;
	private String customid; 
	private String pcode;
	private String pname;
	private int quantity;
	private int price;
	private long total;
	
	
@Override
public String toString() {
	
	return "구매날짜 : " + buy_date + ", 상품 이름 : " + pname + ", 가격 : " + price + ", 수량 : " + quantity+ "\n";
}
	
}
