package com.lin.logistics.mo;

/**
 * @author LINx_x
 * @date 2019/9/28 17:49:02
 */
public class MessageObject {
    private Integer code;
    private String msg;

    public MessageObject(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public MessageObject() {
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
