
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import okhttp3.Call;
import okhttp3.Cookie;
import okhttp3.CookieJar;
import okhttp3.FormBody;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Servlet implementation class Results
 */
@WebServlet("/results.do")
public class Results extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String username;
	String password;
	OkHttpClient client;
	CourseManage courseManage;
	List<Map<String, String>> data;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Results() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		courseManage = new CourseManage();
		client = new OkHttpClient.Builder().cookieJar(new CookieJar() {
			private final HashMap<String, List<Cookie>> cookieStore = new HashMap<String, List<Cookie>>();

			@Override
			public void saveFromResponse(HttpUrl url, List<Cookie> cookies) {
				cookieStore.put(url.host(), cookies);
			}

			@Override
			public List<Cookie> loadForRequest(HttpUrl url) {
				List<Cookie> cookies = cookieStore.get(url.host());
				return cookies != null ? cookies : new ArrayList<Cookie>();
			}
		}).build();
		username = request.getParameter("username");
		password = request.getParameter("password");
		try {
			Login();
			request.setAttribute("data", data);
			request.getRequestDispatcher("/results.jsp").forward(request, response);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	private void Login() throws IOException, InterruptedException {
		RequestBody formBody = new FormBody.Builder().add("zjh", username).add("mm", password).build();
		Request request = new Request.Builder().url("http://jwxt.imu.edu.cn/loginAction.do").post(formBody).build();
		Call call = client.newCall(request);
		Response response = call.execute();
		if (response.isSuccessful()) {
			getGrade();
			data = courseManage.getData();
		}
	}

	private void getGrade() throws InterruptedException {
		getPassed();
		getUnpassed();
		getUnpublished();
	}

	private void getUnpublished() {
		Request.Builder requestBuilder = new Request.Builder()
				.url("http://jwxt.imu.edu.cn/bxqcjcxAction.do?pageSize=300");
		requestBuilder.method("GET", null);
		Request request = requestBuilder.build();
		Call mcall = client.newCall(request);
		try {
			Response response = mcall.execute();
			if (response.isSuccessful()) {
				Document document = Jsoup.parse(response.body().string());
				Elements tr = document.select("tr.odd");
				for (Element element : tr) {
					courseManage.add_unpublished(element);
				}
			}
		} catch (IOException e) {
		}
	}

	private void getUnpassed() {
		Request.Builder requestBuilder = new Request.Builder()
				.url("http://jwxt.imu.edu.cn/gradeLnAllAction.do?type=ln&oper=bjg");
		requestBuilder.method("GET", null);
		Request request = requestBuilder.build();
		Call mcall = client.newCall(request);
		try {
			Response response = mcall.execute();
			if (response.isSuccessful()) {
				Document document = Jsoup.parse(response.body().string());
				Elements tr = document.select("tr.odd");
				for (Element element : tr) {
					courseManage.add_unpassed(element);
				}
			}
		} catch (IOException e) {
		}
	}

	private void getPassed() {
		Request.Builder requestBuilder = new Request.Builder()
				.url("http://jwxt.imu.edu.cn/gradeLnAllAction.do?type=ln&oper=qbinfo");
		requestBuilder.method("GET", null);
		Request request = requestBuilder.build();
		Call mcall = client.newCall(request);
		try {
			Response response = mcall.execute();
			if (response.isSuccessful()) {
				Document document = Jsoup.parse(response.body().string());
				Elements tr = document.select("tr.odd");
				for (Element element : tr) {
					courseManage.add_passed(element);
				}
			}
		} catch (IOException e) {
		}
	}

}
