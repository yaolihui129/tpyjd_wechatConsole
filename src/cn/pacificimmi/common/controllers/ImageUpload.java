package cn.pacificimmi.common.controllers;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;

import cn.pacificimmi.common.QcloudUploader;

public class ImageUpload extends Controller{
	
	private QcloudUploader qcloudUploader = new QcloudUploader();
	
	public void index() throws Exception{  
        Map<String,Object>  result = new HashMap<String,Object>();
        UploadFile uf= getFile("imgFile");
        
        if(uf!=null){
            File file = uf.getFile(); 
            byte[] bytes = File2byte(file.getPath());
            InputStream ins = new ByteArrayInputStream(bytes);
  
	    		String imgUrl = this.getPara("imgUrl");
	    		String picUrl = null;
	
	    		picUrl = qcloudUploader.uploadPic(ins);
	    		if(null != imgUrl && !"".equals(imgUrl)) {
	    			qcloudUploader.deletePic(imgUrl);
	    		}
	    		
	    		if(null != picUrl) {
	    			result.put("error", 0);
	    			result.put("url", picUrl);
	    		} else {
	    			result.put("error", 1);
	            result.put("message", "上传失败.");
	            file.delete();
	    		}
        }else{
            result.put("error", 1);
            result.put("message", "请选择文件");
        }
        this.renderJson(result);
    }
	
	public static byte[] File2byte(String filePath)  
    {  
        byte[] buffer = null;  
        try  
        {  
            File file = new File(filePath);  
            FileInputStream fis = new FileInputStream(file);  
            ByteArrayOutputStream bos = new ByteArrayOutputStream();  
            byte[] b = new byte[1024];  
            int n;  
            while ((n = fis.read(b)) != -1)  
            {  
                bos.write(b, 0, n);  
            }  
            fis.close();  
            bos.close();  
            buffer = bos.toByteArray();  
        }  
        catch (FileNotFoundException e)  
        {  
            e.printStackTrace();  
        }  
        catch (IOException e)  
        {  
            e.printStackTrace();  
        }  
        return buffer;  
    }  
}
