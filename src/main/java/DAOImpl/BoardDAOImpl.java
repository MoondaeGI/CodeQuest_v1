package DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Common.Statics;
import DAO.BoardDAO;
import DTO.BoardDTO;

public enum BoardDAOImpl implements BoardDAO {
	INSTANCE;

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	@Override
	public List<BoardDTO> selectTop5Boardlist() throws Exception {// index 최근게시물 뽑는 메서드
		String sql = "select * from board b inner join members m "
				+ "on b.member_id = m.member_id order by created_at desc limit 5;";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {

			List<BoardDTO> dto = new ArrayList<BoardDTO>();

			while (rs.next()) {

				int id = rs.getInt("board_id");
				int memberId = rs.getInt("member_id");
				String writer = rs.getString("nickname");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				Timestamp regDate = rs.getTimestamp("reg_date");
				int viewCount = rs.getInt("view_count");
				int replyCount = rs.getInt("reply_count");
				String role = rs.getString("role");

				dto.add(new BoardDTO(id, memberId, title, regDate, contents, viewCount, replyCount, writer, role));
			}
			return dto;
		}

	}

	@Override
	public List<BoardDTO> selectAll() throws Exception {
		String sql = "select * from board b inner join members m on b.member_id = m.member_id";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {

			List<BoardDTO> dto = new ArrayList<BoardDTO>();

			while (rs.next()) {

				int id = rs.getInt("board_id");
				int memberId = rs.getInt("member_id");
				String writer = rs.getString("nickname");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				Timestamp regDate = rs.getTimestamp("reg_date");
				int viewCount = rs.getInt("view_count");
				int replyCount = rs.getInt("reply_count");
				String role = rs.getString("role");

				dto.add(new BoardDTO(id, memberId, title, regDate, contents, viewCount, replyCount, writer, role));
			}
			return dto;
		}

	}

	@Override
	public List<BoardDTO> selectBoardList(String searchField, String searchText, int page) throws Exception {
		String insertString = "";
		if (searchField.equals("schTitle")) {
			insertString = " title like ? ";
			
		}
		if (searchField.equals("schWriter")) {
			insertString = " nickname like ?";			
		}
		
		String sql = "select * from(select a.*, ROW_NUMBER() OVER (ORDER BY board_id DESC) AS rnum "
				+ "from (select * from board b inner join members m on b.member_id = m.member_id where role='user' AND" + insertString + ") a) WHERE rnum BETWEEN ? and ?";


		int startIndex = (page - 1) * Statics.recordCountPerPage + 1;
		int endIndex = startIndex + Statics.recordCountPerPage - 1;

		endIndex = (endIndex > searchListgetSize(searchField,searchText)) ? searchListgetSize(searchField,searchText) : endIndex;
		//삼항연사자 -> 조건 ? 참일경우 실행할 내용 : 거짓일경우 실행할 내용;
		try (Connection con = getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
		
			pstat.setString(1, "%" + searchText + "%"); //
			pstat.setInt(2, startIndex);
			pstat.setInt(3, endIndex);
	

			try (ResultSet rs = pstat.executeQuery()) {
				List<BoardDTO> dto = new ArrayList<BoardDTO>();

				while (rs.next()) {

					int id = rs.getInt("board_id");
					int memberId = rs.getInt("member_id");
					String writer = rs.getString("nickname");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp regDate = rs.getTimestamp("reg_date");
					int viewCount = rs.getInt("view_count");
					int replyCount = rs.getInt("reply_count");
					String role = rs.getString("role");

					dto.add(new BoardDTO(id, memberId, title, regDate, contents, viewCount, replyCount, writer, role));
				}
				return dto;
			}
		}

	}

	public BoardDTO selectById(int seq) throws Exception {
		String sql = "	select * from board b inner join members m " + "on b.member_id = m.member_id where board_id= ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setInt(1, seq);

			BoardDTO dto = null;

			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					int boardId = rs.getInt("board_id");
					int memberId = rs.getInt("member_id");
					String writer = rs.getString("nickname");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp regDate = rs.getTimestamp("reg_date");
					int viewCount = rs.getInt("view_count");
					int replyCount = rs.getInt("reply_count");
					String role = rs.getString("role");

					dto = new BoardDTO(boardId, memberId, title, regDate, contents, viewCount, replyCount, writer,
							role);
				}
				return dto;
			}

		}

	}

	@Override
	public int getSize() throws Exception {
		String sql = "select count(*) from board b inner join members m on b.member_id = m.member_id where role = 'user'";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	@Override
	public int searchListgetSize(String searchField, String searchText) throws Exception {
		String sql = "select count(*) from board b inner join members m on b.member_id = m.member_id where";
		if (searchField.equals("schTitle")) {
			sql += " b.title like ? ";

		}
		if (searchField.equals("schWriter")) {
			sql += " m.nickname like ?";

		}

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, "%" + searchText + "%");

			try (ResultSet rs = pstat.executeQuery()) {

				rs.next();

				return rs.getInt(1);
			}

		}
	}

	@Override
	public int deleteById(int boardId) throws Exception {
		String sql = "delete from board where board_id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setInt(1, boardId);
			return pstat.executeUpdate();// 리턴값이 0이면 데이터 변경x
		}
	}

	public void increaseViewCount(int boardId) throws Exception {
		String sql = "update board set view_count = view_count + 1 where board_Id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, boardId);
			pstat.executeUpdate();
		}
	}// 조회수 증가 메서드

	@Override
	public int insert(BoardDTO dto) throws Exception {
		String sql = "insert into board (board_id, title, member_id, contents, reg_date, view_count,reply_count) values (?, ?, ?, ?, sysdate, 0,0)";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, dto.getBoardId());
			pstat.setString(2, dto.getTitle());
			pstat.setInt(3, dto.getMemberId());
			pstat.setString(4, dto.getContents());

			return pstat.executeUpdate();
		}
	}

	@Override
	public int update(BoardDTO dto) throws Exception {

		String sql = "update board set title =?, contents=? where board_id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getBoardId());

			return pstat.executeUpdate();// 리턴값이 0이면 데이터 변경x
		}
	}

	@Override
	public int getNextVal() throws Exception {
		String sql = "select board_id_seq.nextval from dual";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	@Override
	public List<BoardDTO> selectAll(int page) throws Exception {
		String sql = "select * " + "from " + "(select a.*, ROW_NUMBER() OVER (ORDER BY board_id DESC) AS rnum "
				+ "from " + "(select * " + "from board b " + "inner join members m " + "on b.member_id = m.member_id "
				+ "WHERE ROLE = 'user') a) " + "WHERE rnum BETWEEN ? and ?";

		int startIndex = (page - 1) * Statics.recordCountPerPage + 1;
		int endIndex = startIndex + Statics.recordCountPerPage - 1;

		endIndex = (endIndex > getSize()) ? getSize() : endIndex;

		try (Connection con = getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, startIndex);
			pstat.setInt(2, endIndex);

			System.out.println(startIndex + " " + endIndex);
			try (ResultSet rs = pstat.executeQuery()) {
				List<BoardDTO> dto = new ArrayList<BoardDTO>();

				while (rs.next()) {
					int id = rs.getInt("board_id");
					int memberId = rs.getInt("member_id");
					String writer = rs.getString("nickname");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp regDate = rs.getTimestamp("reg_date");
					int viewCount = rs.getInt("view_count");
					int replyCount = rs.getInt("reply_count");
					String role = rs.getString("role");

					dto.add(new BoardDTO(id, memberId, title, regDate, contents, viewCount, replyCount, writer, role));
				}
				return dto;
			}
		}
	}

	@Override
	public List<BoardDTO> selectByMemberId(int memberId) throws Exception { // 마이페이지 최근 작성한 게시글 5개 가져오기
		String sql = "SELECT * FROM ( "
				+ "  SELECT BOARD_ID, MEMBER_ID, TITLE, REG_DATE, CONTENTS, VIEW_COUNT, REPLY_COUNT "
				+ "    FROM board " + "   WHERE MEMBER_ID = ? " + "   ORDER BY BOARD_ID DESC " + ") WHERE ROWNUM <= 6";
		try (Connection con = getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setInt(1, memberId);
			try (ResultSet rs = pstat.executeQuery()) {
				List<BoardDTO> list = new ArrayList<>();
				while (rs.next()) {
					int boardId = rs.getInt("board_id");
					String title = rs.getString("title");
					Timestamp regDate = rs.getTimestamp("reg_date");
					int viewCount = rs.getInt("view_count");
					BoardDTO member = new BoardDTO(boardId, title, regDate, viewCount);
					list.add(member);
				}
				return list;
			}
		}
	}

	@Override
	public void increaseReplyCount(int boardId) throws Exception {
		String sql = "update board set reply_count = reply_count + 1 where board_Id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, boardId);
			pstat.executeUpdate();
		}
	}

	@Override
	public List<BoardDTO> selectAllNotice() throws Exception {
		String sql = "SELECT * FROM BOARD B INNER JOIN MEMBERS M ON B.MEMBER_ID = M.MEMBER_ID WHERE ROLE = 'admin'";

		try (Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<BoardDTO> dto = new ArrayList<>();

			while (rs.next()) {
				dto.add(new BoardDTO(rs.getInt("BOARD_ID"), rs.getInt("MEMBER_ID"), rs.getString("TITLE"),
						rs.getTimestamp("REG_DATE"), rs.getString("CONTENTS"), rs.getInt("VIEW_COUNT"),
						rs.getInt("REPLY_COUNT"), rs.getString("NICKNAME"), rs.getString("ROLE")));
			}

			return dto;
		}
	}

	@Override
	public void decreaseReplyCount(int boardId) throws Exception {
		String sql = "update board set reply_count = reply_count - 1 where board_Id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, boardId);
			pstat.executeUpdate();
		}

	}
}
