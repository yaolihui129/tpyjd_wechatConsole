package cn.pacificimmi.common.utils;

import java.util.List;

import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;

/**加载树
 * @author guyic
 *
 */
public class LoadTreeUtil {
	
	/**构造树
	 * @param dataList 构造树的数据 List
	 * @param dataChecked 默认选中的数据 List
	 * @param rootNodeName 根节点名称
	 * @param selectMode 是否显示选择框
	 * @param allownEdit 是否显示编辑按钮
	 * @return
	 */
	public static String loadAdviserTree(List<Record> dataList,List<String> dataChecked,String rootNodeName,
			Boolean selectMode,Boolean allownEdit,String treeId){
		NodeTree ct = new NodeTree(treeId,rootNodeName,10);
		
		//初始化时将选中的节点，描红显示
		if(dataChecked != null && dataChecked.size()>0){
			ct.setSelectedCodes(dataChecked);
		}
		
		//显示选择框
		ct.setSelectMode(selectMode);
		
		//不显示编辑按钮
		ct.setAllownEdit(allownEdit);
		
		for(Record r:dataList){
			Node node = new Node();
			node.setName(r.getStr("user_name"));
			node.setCode(r.getStr("user_id"));
			node.setId(r.getStr("user_id"));
			ct.addNode(node);
		}
		
		return ct.buildTree();
	}

}
