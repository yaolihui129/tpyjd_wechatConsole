
package cn.pacificimmi.steward.models.view;

import java.math.BigDecimal;
import java.util.Date;

import cn.pacificimmi.common.ComplexModel; 

import com.jfinal.plugin.activerecord.Record;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月27日 下午3:10:31
 **/

public class StewardEvaluateInfo  extends ComplexModel<StewardEvaluateInfo>  {
	private static final long serialVersionUID = 1L;
	private Integer steward_id;
	private Integer evaluate_id;
	private Integer custinfo_id;
	private String name;
	private Double star_level=0d;
	private String content;
	private Integer service_attitude;
	private Integer specialized_knowledge;
	private Integer feedback_efficiency;
	private Date create_time;
	private Integer hidden;
	private String hidden_reason;
	
	public Integer getHidden() {
		return hidden;
	}
	public void setHidden(Integer hidden) {
		this.hidden = hidden;
	}
	public String getHidden_reason() {
		return hidden_reason;
	}
	public void setHidden_reason(String hidden_reason) {
		this.hidden_reason = hidden_reason;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSteward_id() {
		return steward_id;
	}
	public void setSteward_id(Integer steward_id) {
		this.steward_id = steward_id;
	}
	public Integer getEvaluate_id() {
		return evaluate_id;
	}
	public void setEvaluate_id(Integer evaluate_id) {
		this.evaluate_id = evaluate_id;
	}
	public Integer getCustinfo_id() {
		return custinfo_id;
	}
	public void setCustinfo_id(Integer custinfo_id) {
		this.custinfo_id = custinfo_id;
	}
 
	public Double getStar_level() {
		return star_level;
	}
	public void setStar_level(Double star_level) {
		this.star_level = star_level;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getService_attitude() {
		return service_attitude;
	}
	public void setService_attitude(Integer service_attitude) {
		this.service_attitude = service_attitude;
	}
	public Integer getSpecialized_knowledge() {
		return specialized_knowledge;
	}
	public void setSpecialized_knowledge(Integer specialized_knowledge) {
		this.specialized_knowledge = specialized_knowledge;
	}
	public Integer getFeedback_efficiency() {
		return feedback_efficiency;
	}
	public void setFeedback_efficiency(Integer feedback_efficiency) {
		this.feedback_efficiency = feedback_efficiency;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "StewardEvaluateInfo [steward_id=" + steward_id
				+ ", evaluate_id=" + evaluate_id + ", custinfo_id=" + custinfo_id
				+ ", star_level=" + star_level + ", content=" + content
				+ ", service_attitude=" + service_attitude
				+ ", specialized_knowledge=" + specialized_knowledge
				+ ", feedback_efficiency=" + feedback_efficiency
				+ ", create_time=" + create_time + "]";
	}
	 
	
	
	
	
	
}
