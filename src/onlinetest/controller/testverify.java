package onlinetest.controller;
import onlinetest.admn.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               * 
 *        FGIET   B TECH  CSE  Student           *
 *                                               *
 * ***********************************************/                                            

@WebServlet(description = "This servlet has been used to verify many terms related to test", urlPatterns = { "/testverify" })
public class testverify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testverify() {
        super();
        // TODO Auto-generated constructor stub
    }
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		testbean tb=new testbean();
		tb.setCertby(request.getParameter("certby"));
		tb.setDepartment(request.getParameter("department"));
		tb.setTestid(request.getParameter("testid"));
		tb.setTestname(request.getParameter("testname"));
		boolean state=false;
		String message="error";
		try {
			state=tb.isInserted();
			message="Successfully Test Information Inserted";
			if(state)
			       response.sendRedirect("Admin/AdminProfile.jsp");
			else
				   response.sendRedirect("Admin/CreateTest.jsp");
		} catch (Exception e) {
			state=false;
			    message="Unable to insert , either Test id already exist or some error has been occured";
			    response.sendRedirect("Admin/CreateTest.jsp");
		}
	}

}
