package cn.pacificimmi.common.utils;

import java.awt.Color;

/**常量类
 * @author guyic
 *
 */
/**
 * @author Gorge
 * 2016年11月17日
 */
public class ConstantUtil {
	
	public static final String RENDERTEXT_SYS_ERROR = "程序错误!";
	
	public static final String RENDERTEXT_DATA_NULL = "数据不存在!";
	
	public static final String ERROR_PAGE_PATH = "/common/error.jsp";
	
	public static final String PARAM_ERROR = "参数错误!";
	
	/*
	 * 数据状态 - 正常
	 */
	public static final int DATA_STATUS_NORMAL = 0;
	
	/*
	 * 数据状态 - 删除
	 */
	public static final int DATA_STATUS_DELETE = 1;
	
	/*
	 * 数据状态 - 前台删除
	 */
	public static final int DATA_STATUS_FRONT_DELETE = 2;
	
	/*
	 * 操作返回状态-成功
	 */
	public static final int STATUS_SUCCESS = 0;
	
	/*
	 * 操作返回状态 -失败
	 */
	public static final int STATUS_FAILTURE = 1;
	
	/*
	 * 作废（无效客户）
	 */
	public static final String OPERATE_INVALID = "INVALID";
	
	/*
	 * 意向客户
	 */
	public static final String OPERATE_INTENTION = "INTENTION";
	
	/*
	 * 唯一性校验类型
	 */
	
	public static final String VALID_LOGINNAME = "login_name";
	public static final String VALID_LOGINNAME_NAME = "登录名";
	
	public static final String VALID_EMAIL = "email";
	public static final String VALID_EMAIL_NAME = "邮箱";
	
	public static final String VALID_MOBILE = "mobile";
	public static final String VALID_MOBILE_NAME = "手机号";
	
	
	
	/**随机获取颜色
	 * @return
	 */
	public static String color(){
		Color color =  new Color(
				(new Double(Math.random() * 128)).intValue() + 128, 
				(new Double(Math.random() * 128)).intValue() + 128, 
				(new Double(Math.random() * 128)).intValue() + 128);
		return color.toString();
	}
	

}
