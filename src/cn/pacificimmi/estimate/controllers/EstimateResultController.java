package cn.pacificimmi.estimate.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.EstimateQuestion;
import cn.pacificimmi.common.models.EstimateQuestionVersion;
import cn.pacificimmi.common.models.EstimateSelect;
import cn.pacificimmi.common.models.EstimateSelectAdditional;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.estimate.models.view.EstimateResultInfo;
import cn.pacificimmi.estimate.models.view.EstimatetDetailRecordInfo;

/**
 * 评估结果控制器
 * @author Gorge
 */
@Before(LoginInterCeptor.class)
public class EstimateResultController extends Controller {
	private static Logger log = LoggerFactory.getLogger(EstimateResultController.class);
	//评估管理
	public void index() {}
	
	/**
	 * @param edriList
	 * @param project
	 * @return
	 */
	public EstimateResultInfo EstimateResultByProjectId(List<EstimatetDetailRecordInfo> edriList, Project project) {
		String danx = PropKit.use("constants.txt").get("estimate_answer_danx");
		String duox = PropKit.use("constants.txt").get("estimate_answer_duox");
		String wenb = PropKit.use("constants.txt").get("estimate_answer_wenb");
		String coutry = PropKit.use("constants.txt").get("country");
		String hotspots = PropKit.use("constants.txt").get("hotspots");
		String asset = PropKit.use("constants.txt").get("asset");
		String immigration_budget = PropKit.use("constants.txt").get("immigration_budget");
		String qualifications = PropKit.use("constants.txt").get("qualifications");
		String language = PropKit.use("constants.txt").get("language");
		String manage = PropKit.use("constants.txt").get("manage");
		String live_requirement = PropKit.use("constants.txt").get("live_requirement");
		String age = PropKit.use("constants.txt").get("age");
		
		Record di = Db.findFirst("select value from console_dictionary where dict_code="+
				PropKit.use("constants.txt").get("estimate_weight_value")+" and delete_flag=0");
		Integer weight_value = (di.get("value")!=null && !"".equals(di.get("value")))?Integer.parseInt(di.get("value")):0;
		EstimateResultInfo eri = new EstimateResultInfo();
		int num = 0;
		
		for(EstimatetDetailRecordInfo edri:edriList) {
			EstimateQuestion eq = edri.getEstimateQuestion();
			List<EstimateSelectAdditional> esaList = edri.getEsaList();
			String code = eq.getDictCode();
			String answer = eq.getAnswer();
			if(danx.equals(answer) || duox.equals(answer)) {
				if(coutry.equals(code)) { //移民国家
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getCountry() || eri.getCountry() == 1) {
								if(project.getCountry().equals(esa.getDictCode())) {
									eri.setCountry(0);
									num+=eq.getWeight();
								} else {
									eri.setCountry(1);
								}
							}
						}
					}
				} else if(hotspots.equals(code)) { //移民目的
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getHotspots() || eri.getHotspots() == 1) {
								Country country = Country.dao.findFirst("select * from crm_country where country_id = "+project.getCountry()+" and delete_flag=0");
								if(null != country && null !=country.getHotspotsId()) {
									if(country.getHotspotsId().contains(esa.getDictCode())) {
										eri.setHotspots(0);
										num+=eq.getWeight();
									} else {
										eri.setHotspots(1);
									}
								}
							}
						}
					}
				} else if(asset.equals(code)) { //资产要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getAsset() || eri.getAsset() == 1) {
								if(project.getAsset().equals(esa.getDictCode())) {
									eri.setAsset(0);
									num+=eq.getWeight();
								} else {
									eri.setAsset(1);
								}
							}
						}
					}
				} else if(immigration_budget.equals(code)) { //移民预算
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getImmigration_budget() || eri.getImmigration_budget() == 1) {
								if(project.getImmigrationBudget().equals(esa.getDictCode())) {
									eri.setImmigration_budget(0);
									num+=eq.getWeight();
								} else {
									eri.setImmigration_budget(1);
								}
							}
						}
					}
				} else if(qualifications.equals(code)) { //学历要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getQualifications() || eri.getQualifications() == 1) {
								if(project.getQualifications().equals(esa.getDictCode())) {
									eri.setQualifications(0);
									num+=eq.getWeight();
								} else {
									eri.setQualifications(1);
								}
							}
						}
					}
				} else if(language.equals(code)) { //外语能力
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getLanguage() || eri.getLanguage() == 1) {
								if(project.getLanguage().equals(esa.getDictCode())) {
									eri.setLanguage(0);
									num+=eq.getWeight();
								} else {
									eri.setLanguage(1);
								}
							}
						}
					}
				} else if(manage.equals(code)) { //管理经验
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getManage() || eri.getManage() == 1) {
								if(project.getManage().equals(esa.getDictCode())) {
									eri.setManage(0);
									num+=eq.getWeight();
								} else {
									eri.setManage(1);
								}
							}
						}
					}
				} else if(live_requirement.equals(code)) { //居住条件
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getLive_requirement() || eri.getLive_requirement() == 1) {
								if(project.getLiveRequirement().equals(esa.getDictCode())) {
									eri.setLive_requirement(0);
									num+=eq.getWeight();
								} else {
									eri.setLive_requirement(1);
								}
							}
						}
					}
				} else if(age.equals(code)) { //年龄要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getAge() || eri.getAge() == 1) {
								if(project.getAge().equals(esa.getDictCode())) {
									eri.setAge(0);
									num+=eq.getWeight();
								} else {
									eri.setAge(1);
								}
							}
						}
					}
				}
			//数值类型
			} else if(wenb.equals(answer)) {
				if(coutry.equals(code)) { //移民国家
					if(null == eri.getCountry() || eri.getCountry() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getCountry())) {
									eri.setCountry(1);
								} else {
									eri.setCountry(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setCountry(1);
							}
						} else {
							eri.setCountry(1);
						}
					} else {
						eri.setCountry(1);
					}
				} else if(hotspots.equals(code)) { //移民目的
					if(null == eri.getHotspots() || eri.getHotspots() == 1) {
						if(null != edri.getInt_value()) {
							try{
								Country country = Country.dao.findFirst("select * from crm_country where country_id = "+project.getCountry()+" and delete_flag=0");
								if(null != country && null !=country.getHotspotsId() && edri.getInt_value()< new Integer(country.getHotspotsId())) {
									eri.setHotspots(1);
								} else {
									eri.setHotspots(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setHotspots(1);
							}
						} else {
							eri.setHotspots(1);
						}
					} else {
						eri.setHotspots(1);
					}
				} else if(asset.equals(code)) { //资产要求
					if(null == eri.getAsset() || eri.getAsset() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getAsset())) {
									eri.setAsset(1);
								} else {
									eri.setAsset(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setAsset(1);
							}
						} else {
							eri.setAsset(1);
						}
					} else {
						eri.setAsset(1);
					}
				} else if(immigration_budget.equals(code)) { //移民预算
					if(null == eri.getAsset() || eri.getAsset()==1) {
						for(EstimatetDetailRecordInfo dr:edriList) {
							EstimateQuestion eqn = dr.getEstimateQuestion();
							String dcode = eq.getDictCode();
							String danswer = eq.getAnswer();
							if(asset.equals(dcode)) {
								if(danx.equals(danswer) || duox.equals(danswer)) {
									List<EstimateSelectAdditional> esas= dr.getEsaList();
									if(null != esas && esas.size()>0) {
										for(EstimateSelectAdditional desa:esas) {
											if(null ==eri.getAsset() || eri.getAsset() == 1) {
												if(project.getAsset().equals(desa.getDictCode())) {
													eri.setAsset(0);
													num+=eq.getWeight();
												} else {
													eri.setAsset(1);
												}
											}
										}
									}
								} else if(wenb.equals(danswer)){
									if(null == eri.getAsset() || eri.getAsset() == 1) {
										if(null != edri.getInt_value()) {
											try{
												if(edri.getInt_value()<new Integer(project.getAsset())) {
													eri.setAsset(1);
												} else {
													eri.setAsset(0);
													num+=eq.getWeight();
												}
											}catch(Exception e) {
												eri.setAsset(1);
											}
										} else {
											eri.setAsset(1);
										}
									} else {
										eri.setAsset(1);
									}
								}
							}
						}
					}
					
					if(null == eri.getAsset() || eri.getAsset()==1) {
						eri.setImmigration_budget(1);
					} else if(eri.getAsset() == 0) {
						if(null != edri.getInt_value()) {
							if(edri.getInt_value()<project.getImmigrationBudget()) {
								eri.setImmigration_budget(2);
								num+=(eq.getWeight()/2);
							} else {
								eri.setImmigration_budget(0);
								num+=eq.getWeight();
							}
						} else {
							eri.setImmigration_budget(1);
						}
					}
					
				} else if(qualifications.equals(code)) { //学历要求
					if(null == eri.getQualifications() || eri.getQualifications() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getQualifications())) {
									eri.setQualifications(1);
								} else {
									eri.setQualifications(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setQualifications(1);
							}
						} else {
							eri.setQualifications(1);
						}
					} else {
						eri.setQualifications(1);
					}
				} else if(language.equals(code)) { //外语能力
					if(null == eri.getLanguage() || eri.getLanguage() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getLanguage())) {
									eri.setLanguage(1);
								} else {
									eri.setLanguage(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setLanguage(1);
							}
						} else {
							eri.setLanguage(1);
						}
					} else {
						eri.setLanguage(1);
					}
				} else if(manage.equals(code)) { //管理经验
					if(null == eri.getManage() || eri.getManage() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getManage())) {
									eri.setManage(1);
								} else {
									eri.setManage(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setManage(1);
							}
						} else {
							eri.setManage(1);
						}
					} else {
						eri.setManage(1);
					}
				} else if(live_requirement.equals(code)) { //居住条件
					if(null == eri.getLive_requirement() || eri.getLive_requirement() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getLiveRequirement())) {
									eri.setLive_requirement(1);
								} else {
									eri.setLive_requirement(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setLive_requirement(1);
							}
						} else {
							eri.setLive_requirement(1);
						}
					} else {
						eri.setLive_requirement(1);
					}
				} else if(age.equals(code)) { //年龄要求
					if(null == eri.getAge() || eri.getAge() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getAge())) {
									eri.setAge(1);
								} else {
									eri.setAge(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setAge(1);
							}
						} else {
							eri.setAge(1);
						}
					} else {
						eri.setAge(1);
					}
				}
			}
		}
		
		if(num>weight_value || num==weight_value) {
			eri.setMatching(num);
			eri.setProjectId(project.getProjectId());
			eri.setProjectName(project.getProjectName());
			eri.setRecommended(new Integer(project.getRecommended()));
			eri.setOnline_time(project.getOnlineTime());
			return eri;
		}
		return null;
	}
}
