/**
 * 
 */
package websocket.util;


import redis.clients.jedis.Jedis;

/**
 * @author:lvfang
 * @date:2018-10-28
 * @desc:
 * @version:V1.0 
 */
public class JedisUtil {

	public static final Jedis jedis;

    static {
        //家庭环境
//        jedis = new Jedis("0.0.0.0",6379,5000);
//        jedis.auth("123");
        //工作环境
//        jedis = new Jedis("0.0.0.0",6379,5000);
//        jedis.auth("123");
        //测试环境
        jedis = new Jedis("127.0.0.1",6379,5000);
//        jedis.auth("123");
    }
}
