package koreait.jdbc.day4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import koreait.jdbc.day2.OracleUtility;

public class JMypageDao {
		
	public List<JMypage> Mypage(String customid) throws SQLException {
		Connection conn = OracleUtility.getConnection();
		String sql = "select * from mypage_buy where customid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, customid);
		
		ResultSet rs = ps.executeQuery();
		
		List<JMypage> page = new ArrayList<>();
		while(rs.next()) {
			page.add(new JMypage(rs.getDate(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getInt(5),
					rs.getInt(6),
					rs.getLong(7)));
		}
		ps.close();
		conn.close();
		return page;		
	}
	
	
	public long myMoney(String customid) throws SQLException {
		Connection conn = OracleUtility.getConnection();
		String sql = "select sum(total) from mypage_buy where customid=?";
		//함수 조회하는 select는 항상 결과 행이 1개, 컬럼도 1개입니다.
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, customid);
		
		ResultSet rs = ps.executeQuery();
		long total = 0l;
		while(rs.next()) {
			total = rs.getLong(1);
		}
		ps.close();
		conn.close();
		
		return total;
		
	}
}
