package cn.pacificimmi.project.models.view;

import cn.pacificimmi.common.ComplexModel;

public class ProjectCostInfo extends ComplexModel<ProjectCostInfo> {
	
	/**
	 * 项目费用id
	 */
	private Integer project_cost_id;
	
	/**
	 * 项目id
	 */
	private Integer project_id;
	
	/**
	 * 费用项名称
	 */
	private String name;
	
	/**
	 * 收费机构
	 */
	private String institution;
	
	/**
	 * 金额
	 */
	private String cost;
	
	/**
	 * 收费阶段
	 */
	private String charge_stage;
	
	/**
	 * 退款标准
	 */
	private String refund_standard;

	public Integer getProject_cost_id() {
		return project_cost_id;
	}

	public void setProject_cost_id(Integer project_cost_id) {
		this.project_cost_id = project_cost_id;
	}

	public Integer getProject_id() {
		return project_id;
	}

	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInstitution() {
		return institution;
	}

	public void setInstitution(String institution) {
		this.institution = institution;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getCharge_stage() {
		return charge_stage;
	}

	public void setCharge_stage(String charge_stage) {
		this.charge_stage = charge_stage;
	}

	public String getRefund_standard() {
		return refund_standard;
	}

	public void setRefund_standard(String refund_standard) {
		this.refund_standard = refund_standard;
	}

	
}
