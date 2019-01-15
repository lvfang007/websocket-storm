package websocket.socket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import websocket.util.JedisUtil;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.util.Date;


@ServerEndpoint("/echo")
public class EchoSocket {

	private static final Logger logger = LoggerFactory.getLogger(EchoSocket.class);
	
	/**
	 * 构造方法
	 */
	public EchoSocket(){
		System.out.println("执行一次构造，创建一个EchoSocket对象");//这个对象是多例的，即进来一个用户会创建一个对象，可以理解为MVC的controller
	}

	/**
	 * 打开通道执行
	 * @param session
	 * @throws Exception
	 */
	@OnOpen
	public void open(Session session) throws Exception{
		int i=0;	
		try{
			//一个session代表一个通信会话
			System.out.println("sessionId" + session.getId() + "通道打开");
		}catch(Exception e){
			System.out.println("通道异常关闭！open");
		}
	}
	
	/**
	 * 接收客户端发来的信息
	 * @param session
	 * @param message
	 */
	@OnMessage
	public void message(Session session,String message){
		try{
			System.out.println("客户端发送数据：" + message);
			//session.getBasicRemote().sendText("一条消息！" + new Random().nextInt(100));
			if("admin".equals(message)){
				while(true){
					String str1 = JedisUtil.jedis.hget("storm_test","优惠前总价");
					String str2 = JedisUtil.jedis.hget("storm_test","优惠后总价");
					String str3 = JedisUtil.jedis.hget("storm_test","活动用户数");
					String str4 = JedisUtil.jedis.hget("storm_test","活动订单数");
					String info =  str1 + "," + str2 + "," + str3 + "," + str4;
//					logger.info("获取数据 {}",info);
					session.getBasicRemote().sendText(info);
					//Thread.sleep(500);
				}
			}else{
				session.getBasicRemote().sendText( "错误的秘钥，不能浏览内部数据！！");
			}

		}catch(Exception e){
			System.out.println("通道异常关闭！message");
		}
	}
	
	/**
	 * 通道关闭执行（可以理解为关闭浏览器）
	 * @param session
	 */
	@OnClose
	public void close(Session session){
		try{
			System.out.println("sessionId" + session.getId() + "通道关闭");
		}catch(Exception e){
			System.out.println("通道异常关闭！close");
		}
		
	}
}
