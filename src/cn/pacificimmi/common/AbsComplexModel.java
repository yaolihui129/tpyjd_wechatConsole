package cn.pacificimmi.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Date;

import com.jfinal.plugin.activerecord.Record;

public abstract class AbsComplexModel<T> {
	public void bindingData(T model,Record r){
		try{ 
			Field[] field = model.getClass().getDeclaredFields();
	        for(int j=0 ; j<field.length ; j++){
	                String name = field[j].getName();
	                String alias = getAlias(name);
	          	
	                String type = field[j].getGenericType().toString();
	                if(type.equals("class java.lang.String")){
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),String.class);
	                    String value = r.getStr(name);
	                    if(value!=null)
	                    		m.invoke(model, value);
	                    else{
	                    		value = r.getStr(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }
	                if(type.equals("class java.lang.Integer")){     
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Integer.class);
	                    Integer value = r.getInt(name);
	                    if(value != null){
	                    		m.invoke(model, value);
	                    }
	                    else{
	                    		value = r.getInt(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }
	                if(type.equals("class java.lang.Short")){     
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Short.class);
	                    Short value = (Short) r.get(name);
	                    if(value != null){
	                    		m.invoke(model, value);                    
	                    	}
	                    else{
	                    		value = (Short) r.get(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }       
	                if(type.equals("class java.lang.Double")){     
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Double.class);
	                    Double value = r.getDouble(name);
	                    if(value != null){                    
	                    		m.invoke(model, value);
	                    }
	                    else{
	                    		value = r.getDouble(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }     
	                if(type.equals("class java.lang.Float")){     
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Float.class);
	                    Float value = r.getFloat(name);
	                    if(value != null){                    
	                    		m.invoke(model, value);
	                    }
	                    else{
	                    		value = r.getFloat(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }    
	                if(type.equals("class java.lang.Boolean")){
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Boolean.class);    
	                    Integer value = r.getInt(name);
	                    if(value != null){
	                    		if(value>0)
	                    			m.invoke(model, true);
	                    		else
	                    			m.invoke(model, false);
	                    }
	                    else{
	                    		value = r.getInt(alias);
	                    		if(value>0)
	                    			m.invoke(model, true);
	                    		else
	                    			m.invoke(model, false);
	                    }
	                }
	                if(type.equals("class java.util.Date")){
	                    Method m = model.getClass().getMethod("set"+InitialCapitalization(name),Date.class);                    
	                    Date value = r.getDate(name);
	                    if(value != null){
	                    		m.invoke(model, value);
	                    }
	                    else{
	                    		value = r.getDate(alias);
	                    		if(value!=null)
		                    		m.invoke(model, value);
	                    }
	                }                
	       }
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private String InitialCapitalization(String word){
		if(word==null || word.isEmpty())
			return word;
		else{
			char initial = word.charAt(0);
			StringBuffer bf = new StringBuffer();
			bf.append(Character.toUpperCase(initial));
			bf.append(word.substring(1));
			return bf.toString();
		}
	}
	
	private String getAlias(String name){
		String alias="";
		for(int i=0;i<name.length();i++){
			char ch = name.charAt(i);
			if(Character.isUpperCase(ch)){
				alias += "_"+Character.toLowerCase(ch);
			}
			else{
				alias += ch;
			}
		}
		return alias;
	}
}
