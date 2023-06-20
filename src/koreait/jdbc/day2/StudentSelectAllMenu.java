package koreait.jdbc.day2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentSelectAllMenu {

	public static void main(String[] args) {
		Connection conn = OracleUtility.getConnection();
		System.out.println("========학생 조회 메뉴==========");
		stundentSelectAllmenu(conn);
		
		OracleUtility.close(conn);
	}
	
	private static void stundentSelectAllmenu(Connection conn) {
		String sql = "select * from TBL_Student";
		try( PreparedStatement ps = conn.prepareStatement(sql);	
				){
				
				ResultSet rs = ps.executeQuery();	//select 실행하기
				while(rs.next()) {	//주의 : 테이블 컬럼의 구조를 알아야 인덱스를 정할 수 있습니다.
				System.out.println(String.format("학번 : %s , 이름  : %s , 나이 : %d , 주소 : %s" , rs.getString(1),rs.getString(2),rs.getInt(3),rs.getString(4)));
				}
			}
			
				catch(SQLException e) {
				System.out.println("데이터 조회에 문제가 생겼습니다. 상세내용 -" + e.getMessage());
				// 결과 집합을 모두 소모했음 -> 조회 결과가 없는데 rs.getXXXX 메소드 실행 할 때의 예외 메시지.
			}

		
	}
}	

