

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.Call;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Servlet implementation class Login
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login.do" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		OkHttpClient client=new OkHttpClient();
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		RequestBody formBody = new FormBody.Builder()
                .add("zjh", username)
                .add("mm", password)
                .build();
        Request  mrequest = new Request.Builder()
                .url("http://jwxt.imu.edu.cn/loginAction.do")
                .post(formBody)
                .build();
        Call call=client.newCall(mrequest);
        Response mResponse=call.execute();
        if(mResponse.isSuccessful()){
        	String mString=mResponse.body().string();
        	if(mString.contains("mainFrame.jsp")){
        		response.getWriter().println("{\"valid\":true}");
        	}else{
        		response.getWriter().println("{\"valid\":false}");
        	}
        	
        }else{
        	response.getWriter().println("{\"valid\":false}");
        }
	}

}
