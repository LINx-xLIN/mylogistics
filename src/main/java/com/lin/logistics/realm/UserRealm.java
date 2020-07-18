package com.lin.logistics.realm;

import com.lin.logistics.pojo.Permission;
import com.lin.logistics.pojo.PermissionExample;
import com.lin.logistics.pojo.User;
import com.lin.logistics.pojo.UserExample;
import com.lin.logistics.service.PermissionService;
import com.lin.logistics.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

public class UserRealm  extends AuthorizingRealm {
    @Autowired
    private UserService userService;
    @Autowired
    private PermissionService permissionService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        User user = (User) principals.getPrimaryPrincipal();

        String permissionIdsStr = user.getPermissionIds();

        if(StringUtils.isNotBlank(permissionIdsStr)){
            String[] permissionIdsArrByStr = permissionIdsStr.split(",");
            List<Long> permissionIdsByLong = new ArrayList<>();
            for(String permissionId:permissionIdsArrByStr){
                permissionIdsByLong.add(Long.valueOf(permissionId));
            }
            PermissionExample example = new PermissionExample();
            PermissionExample.Criteria criteria = example.createCriteria();
            criteria.andPermissionIdIn(permissionIdsByLong);
            List<Permission> permissions = permissionService.selectByExample(example);
            SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
            for(Permission permission:permissions){
                if(StringUtils.isNotBlank(permission.getExpression())){
                    authorizationInfo.addStringPermission(permission.getExpression());
                }
            }

            return authorizationInfo;

        }
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        String username = (String) token.getPrincipal();

        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        List<User> users = userService.selectByExample(example);
        if(users.size()<1){
            return null;
        }
        User principal = users.get(0);

        String hashedCredentials = principal.getPassword();

        String salt = principal.getSalt();
        ByteSource credentialsSalt = ByteSource.Util.bytes(salt);

        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(principal, hashedCredentials, credentialsSalt, this.getName());


        return authenticationInfo;

    }
}
