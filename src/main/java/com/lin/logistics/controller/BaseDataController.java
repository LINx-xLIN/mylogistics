package com.lin.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.mo.MessageObject;
import com.lin.logistics.pojo.BaseData;
import com.lin.logistics.pojo.BaseDataExample;
import com.lin.logistics.service.BaseDataService;
import com.lin.logistics.service.RoleService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/26 15:27:33
 */
@Controller
@RequestMapping("/baseData")
public class BaseDataController {

    @Autowired
    private BaseDataService baseDataService;


    @RequestMapping("/baseDataPage")
    @RequiresPermissions("basicData:basicDatapage")
    public String baseDataPage(){
        return "baseDataPage";
    }

    @RequestMapping("/list")
    @ResponseBody
    @RequiresPermissions("basicData:list")
    public PageInfo<BaseData> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        BaseDataExample example = new BaseDataExample();



        if(StringUtils.isNotBlank(keyword)){
            BaseDataExample.Criteria criteria = example.createCriteria();
            criteria.andBaseNameLike("%"+keyword+"%");
            BaseDataExample.Criteria criteria1 = example.createCriteria();
            criteria1.andBaseDescLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<BaseData> baseDatas = baseDataService.selectByExample(example);
        PageInfo<BaseData> pageInfo = new PageInfo<>(baseDatas);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("basicData:delete")
    public MessageObject delete(Long baseDataId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = baseDataService.deleteByPrimaryKey(baseDataId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions("basicData:batchdelete")
    public MessageObject batchDelete(@RequestParam(value="baseDataIds[]") List<Long> baseDataIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        BaseDataExample baseDataExample = new BaseDataExample();
        BaseDataExample.Criteria criteria = baseDataExample.createCriteria();
        criteria.andBaseIdIn(baseDataIds);
        int row = baseDataService.deleteByExample(baseDataExample);
        if(row == baseDataIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long baseDataId){

        if(baseDataId != null){
            BaseData baseData = baseDataService.selectByPrimaryKey(baseDataId);
            m.addAttribute("baseData",baseData);

        }




        BaseDataExample example = new BaseDataExample();
        BaseDataExample.Criteria criteria = example.createCriteria();
        criteria.andParentIdIsNull();
        List<BaseData> baseDatas = baseDataService.selectByExample(example);
        m.addAttribute("baseDatas",baseDatas);


        return "baseDataEdit";
    }
    @RequestMapping("/checkBaseDataname")
    @ResponseBody
    public boolean checkBaseDataname(String name){
        BaseDataExample example = new BaseDataExample();
        BaseDataExample.Criteria criteria = example.createCriteria();
        criteria.andBaseNameEqualTo(name);
        List<BaseData> baseDatas = baseDataService.selectByExample(example);
        return !(baseDatas.size()>0);
    }

    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("basicData:insert")
    public MessageObject insert(BaseData baseData){
        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = baseDataService.insert(baseData);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("basicData:update")
    public MessageObject update(BaseData baseData){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        int row = baseDataService.updateByPrimaryKeySelective(baseData);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }

    @RequestMapping("/getAllBaseData")
    @ResponseBody
    public List<BaseData> getAllBaseData(){
        BaseDataExample example = new BaseDataExample();
        List<BaseData> baseDatas = baseDataService.selectByExample(example);
        return baseDatas;
    }


}


