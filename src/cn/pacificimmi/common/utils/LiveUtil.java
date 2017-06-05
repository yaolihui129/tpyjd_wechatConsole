package cn.pacificimmi.common.utils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import cn.pacificimmi.common.models.Channel;

import org.apache.http.Consts;

import java.io.IOException;
import java.util.Date;

public class LiveUtil {
	public static String CreateChannel(String channelName){
		DefaultHttpClient httpClient = new DefaultHttpClient();
        String url = "https://vcloud.163.com/app/channel/create";
        HttpPost httpPost = new HttpPost(url);

        String appKey = "c46641a06d1b71b7820757340707359a";
        String appSecret = "b5e88a548827";
        String nonce = MajorKeyFactory.getInstance().getMajorKey();
        String curTime = String.valueOf((new Date()).getTime() / 1000L);
        String checkSum = CheckSumBuilder.getCheckSum(appSecret, nonce ,curTime);//参考 计算CheckSum的java代码

        // 设置请求的header
        httpPost.addHeader("AppKey", appKey);
        httpPost.addHeader("Nonce", nonce);
        httpPost.addHeader("CurTime", curTime);
        httpPost.addHeader("CheckSum", checkSum);
        httpPost.addHeader("Content-Type", "application/json;charset=utf-8");

        // 设置请求的参数
        StringEntity params = new StringEntity("{\"name\":\""+channelName+"\", \"type\":0}",Consts.UTF_8);
        httpPost.setEntity(params);

        // 执行请求
        HttpResponse response;
		try {
			response = httpClient.execute(httpPost);
			// 打印执行结果
			String rst = EntityUtils.toString(response.getEntity(), "utf-8");
	        System.out.println(rst);
	        return rst;
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
	}
	
	public static void deleteChannel(String channelId){
		DefaultHttpClient httpClient = new DefaultHttpClient();
        String url = "https://vcloud.163.com/app/channel/delete";
        HttpPost httpPost = new HttpPost(url);

        String appKey = "c46641a06d1b71b7820757340707359a";
        String appSecret = "b5e88a548827";
        String nonce = MajorKeyFactory.getInstance().getMajorKey();
        String curTime = String.valueOf((new Date()).getTime() / 1000L);
        String checkSum = CheckSumBuilder.getCheckSum(appSecret, nonce ,curTime);//参考 计算CheckSum的java代码

        // 设置请求的header
        httpPost.addHeader("AppKey", appKey);
        httpPost.addHeader("Nonce", nonce);
        httpPost.addHeader("CurTime", curTime);
        httpPost.addHeader("CheckSum", checkSum);
        httpPost.addHeader("Content-Type", "application/json;charset=utf-8");

        // 设置请求的参数
        StringEntity params = new StringEntity("{\"cid\":\""+channelId+"\", \"type\":0}",Consts.UTF_8);
        httpPost.setEntity(params);

        // 执行请求
        HttpResponse response;
		try {
			response = httpClient.execute(httpPost);
			// 打印执行结果
	        System.out.println(EntityUtils.toString(response.getEntity(), "utf-8"));
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		//LiveUtil.CreateChannel("测试");
		//LiveUtil.deleteChannel("7f3fd9ed7f7a40b3a192efee25aa8262");
	}
}
