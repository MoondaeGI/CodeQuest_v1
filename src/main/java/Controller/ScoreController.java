package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Common.ConvertURL;
import DAOImpl.GameImpl;
import DAOImpl.ScoreDAOImpl;
import DTO.ScoreDTO;

@WebServlet("/score/*")
public class ScoreController extends HttpServlet {
	ScoreDAOImpl scoreDAO = ScoreDAOImpl.INSTANCE;
	GameImpl gameDAO = GameImpl.INSTANCE;
	
	Gson g = new Gson();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		try {		
			String cmd = ConvertURL.of(request);
			
			if (cmd.equals("/score/list/game.do")) {
				String gameId = request.getParameter("id");
				String userId = request.getParameter("user");
				
				List<ScoreDTO> dto = new ArrayList<>();
				dto = (userId == null) ? 
						scoreDAO.selectByGameId(Integer.parseInt(gameId)) : 
						scoreDAO.selectByMemberIdAndGameId(Integer.parseInt(userId), Integer.parseInt(gameId));

				response.getWriter().append(g.toJson(dto));
			} else if (cmd.equals("/score/list/game/user.do")) {
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
