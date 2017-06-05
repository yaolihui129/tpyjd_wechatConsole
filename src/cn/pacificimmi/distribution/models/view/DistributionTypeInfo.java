
package cn.pacificimmi.distribution.models.view;

import java.io.Serializable;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月24日 下午5:48:26
 **/

public class DistributionTypeInfo  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String dist_type_id;
	private String dist_type_name;
	private String dist_type_sort;
	private String dist_type_create_time;
	
	
	public String getDist_type_id() {
		return dist_type_id;
	}
	public void setDist_type_id(String dist_type_id) {
		this.dist_type_id = dist_type_id;
	}
	public String getDist_type_name() {
		return dist_type_name;
	}
	public void setDist_type_name(String dist_type_name) {
		this.dist_type_name = dist_type_name;
	}
	public String getDist_type_sort() {
		return dist_type_sort;
	}
	public void setDist_type_sort(String dist_type_sort) {
		this.dist_type_sort = dist_type_sort;
	}
	public String getDist_type_create_time() {
		return dist_type_create_time;
	}
	public void setDist_type_create_time(String dist_type_create_time) {
		this.dist_type_create_time = dist_type_create_time;
	}
	@Override
	public String toString() {
		return "DistributionTypeInfo [dist_type_id=" + dist_type_id
				+ ", dist_type_name=" + dist_type_name + ", dist_type_sort="
				+ dist_type_sort + ", dist_type_create_time="
				+ dist_type_create_time + "]";
	}
	 
	
	
}
