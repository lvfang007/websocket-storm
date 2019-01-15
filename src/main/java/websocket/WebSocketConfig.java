package websocket;

import java.util.Set;

import javax.websocket.Endpoint;
import javax.websocket.server.ServerApplicationConfig;
import javax.websocket.server.ServerEndpointConfig;

/**
 * webSocket的启动类，可以理解为spring的类加载监听器
 * ClassName: WebSocketConfig
 * @author lvfang
 * @Desc: TODO
 * @date 2018-1-30
 * 
 * 只要实现ServerApplicationConfig接口，则会在容器启动时自动调用
 */
public class WebSocketConfig implements ServerApplicationConfig {

	/*
	 * 1.  getAnnotatedEndpointClasses
	 * 2.  getEndpointConfigs
	 * 
	 * 上面的两个方法都是用来注册 webSocket的。   只不过注册的方式不同。  1方法是 注解的方式
	 * 2方法是 接口的方式
	 * 
	 * 显然 注解的方式更加的 灵活简单。  接口的方式更加的传统，严谨。
	 * 
	 * (non-Javadoc)
	 * @see javax.websocket.server.ServerApplicationConfig#getAnnotatedEndpointClasses(java.util.Set)
	 */
	
	/**
	 * 当启动容器时，tomcat会扫描所有的endPoint（相当于servlet），并返回一个set集合
	 * 
	 * 注解方式启动
	 */
	public Set<Class<?>> getAnnotatedEndpointClasses(Set<Class<?>> endPoints) {
		System.out.println("正在扫描吕方的websocket服务... ... , 有" + endPoints.size() + "个endpoint");
		System.out.println("注解方式启动------------------");
		//所有返回的endpoint才会起作用，所以这里可以起到过滤作用
		return endPoints;
	}

	/**
	 * 编程方式启动
	 */
	public Set<ServerEndpointConfig> getEndpointConfigs(
			Set<Class<? extends Endpoint>> arg0) {
		// TODO Auto-generated method stub
		System.out.println("接口方式启动------------------");
		return null;
	}

}
