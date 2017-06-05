package cn.pacificimmi.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.SimpleHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpClientParams;

public class HttpUtils {
	
	public static void doGet(){
	}
	
	public static String doGet(String url){
    	HttpClient client = null;
		GetMethod method = null;
		String response = "";
		try {
			System.out.println(url);
			client = new HttpClient(new HttpClientParams(), new SimpleHttpConnectionManager(true));
			client.getHttpConnectionManager().getParams()
            .setConnectionTimeout(50000);// 设置连接时间
			method = new GetMethod(url);
			method.addRequestHeader("Content-Type","text/html;charset=UTF-8");
			int status = client.executeMethod(method);
			if(status == HttpStatus.SC_OK){
				InputStream inputStream = method.getResponseBodyAsStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(
                        inputStream));
                StringBuffer stringBuffer = new StringBuffer();
                String str = "";
                while ((str = br.readLine()) != null) {
                    stringBuffer.append(str);
                }
                response = stringBuffer.toString();
			}
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			method.releaseConnection();
		}
    	return response;
    }
    
    public static String doPost(String url){
    	if(StringUtils.isEmpty(url))
            return null;
        String response = "";
        PostMethod postMethod = new PostMethod(url);
        postMethod.addRequestHeader("Content-Type","text/html;charset=UTF-8");  
        try {
            HttpClient client = new HttpClient();
            client.getHttpConnectionManager().getParams()
                    .setConnectionTimeout(50000);// 设置连接时间
            int status = client.executeMethod(postMethod);
            if (status == HttpStatus.SC_OK) {
                InputStream inputStream = postMethod.getResponseBodyAsStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(
                        inputStream ,"utf-8"));
                StringBuffer stringBuffer = new StringBuffer();
                String str = "";
                while ((str = br.readLine()) != null) {
                    stringBuffer.append(str);
                }
                response = stringBuffer.toString();
            } else {
                response = "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 释放连接
            postMethod.releaseConnection();
        }
        return response;
    }
    
    /**callcenter 外呼V2接口鉴权
     * @param fromExten 坐席工号 （必须）
     * @param exten 被叫号码 （必须）
     * @param extenType 外呼接听方式： Local为“手机”sip为“软电话”gateway为“语音网关” （可选）
     * @param actionId 随机码，用户用来标识请求的操作,会返回 （可选）
     * @return
     */
    public static String icallDialoutV2(String fromExten,String exten,String extenType,String actionId){
    	String account = "N00000011728";
    	String APISecret = "e2aa1b00-fd62-11e6-abdc-6744bc06d173";
    	String curDatetime = TpyDateUtil.getDateString();
    	String url = "http://apis.7moor.com/v20160818/call/dialout/"+account+"?sig="+MD5Util.MD5(account+APISecret+curDatetime).toUpperCase();
    	String response = "";
        
    	PostMethod postMethod = new PostMethod(url);
        try {
        		
            postMethod.addRequestHeader("Accept","application/json");
            postMethod.addRequestHeader("Content-Type","application/json;charset=utf-8;");
            //postMethod.addRequestHeader("Content-Length","256");
            postMethod.addRequestHeader("Authorization",Base64Utils.encode(account+":"+curDatetime));
           
            String params ="{\"FromExten\":\""+fromExten+"\",\"Exten\":\""+exten+"\"";
            if(null != extenType && !extenType.isEmpty()){
            		params += ",\"ExtenType\":\""+extenType+"\"";
            }
            if(null != actionId && !actionId.isEmpty()){
        			params += ",\"ActionId\":"+actionId+"\"";
            }
            params += "}";
            
            postMethod.setRequestEntity(new StringRequestEntity(params,"text/xml","UTF-8"));
        	
            HttpClient client = new HttpClient();
            client.getHttpConnectionManager().getParams()
                    .setConnectionTimeout(50000);// 设置连接时间
            int status = client.executeMethod(postMethod);
            if (status == HttpStatus.SC_OK) {
                InputStream inputStream = postMethod.getResponseBodyAsStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(
                        inputStream ,"utf-8"));
                StringBuffer stringBuffer = new StringBuffer();
                String str = "";
                while ((str = br.readLine()) != null) {
                    stringBuffer.append(str);
                }
                response = stringBuffer.toString();
            } else {
                response = "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 释放连接
            postMethod.releaseConnection();
        }
        return response;
    }

}
