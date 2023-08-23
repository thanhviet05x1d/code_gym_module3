package com.three_group_store.common.account;

import java.util.HashMap;
import java.util.Map;

public class ValidateAccount {
    private static final String MAIL_REGEX = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";

    public static Map<String, String> checkLogin(String userName, String password) {
        Map<String, String> errMap = new HashMap<>();
        String errUserName;
        if ((errUserName = checkUserName(userName)) != null) {
            errMap.put("errUserName", errUserName);
        }
        String errPassword;
        if ((errPassword = checkPassword(password)) != null) {
            errMap.put("errPassword", errPassword);
        }
        return errMap;
    }

    private static String checkPassword(String password) {
        if (password == null || password.equals("")) {
            return "Mật khẩu không được để trống!";
        } else if (password.length() < 8) {
            return "Mật khẩu phải có ít nhất là 8 kí tự!";
        } else if (password.length() > 55) {
            return "Mật khẩu giới hạn 55 kí tự!";
        }
        return null;
    }

    public static String checkUserName(String userName) {
        if (userName == null || userName.trim().equals("")) {
            return "Tài khoản đăng nhập không được để trống!";
        } else if (!userName.matches(MAIL_REGEX)) {
            return "Tài khoản đăng nhập phải có dạng abc@abc.abc";
        } else if (userName.length() > 255) {
            return "Tài khoản đăng nhập giới ạn 255 kí tự!";
        }
        return null;
    }

    public static Map<String, String> checkRegister(String userName, String password, String confirmPassword) {
        Map<String, String> errMap = new HashMap<>();
        String errUserName;
        if ((errUserName = checkUserName(userName)) != null) {
            errMap.put("errUserName", errUserName);
        }
        String errPassword;
        if ((errPassword = checkPassword(password)) != null) {
            errMap.put("errPassword", errPassword);
        }
        String errConfirmPassword;
        if ((errConfirmPassword = checkConfirmPassword(confirmPassword)) != null) {
            errMap.put("errConfirmPassword", errConfirmPassword);
        }
        return errMap;
    }

    private static String checkConfirmPassword(String confirmPassword) {
        if (confirmPassword == null || confirmPassword.equals("")) {
            return "Mật khẩu không được để trống!";
        } else if (confirmPassword.length() < 8) {
            return "Mật khẩu phải có ít nhất là 8 kí tự!";
        } else if (confirmPassword.length() > 55) {
            return "Mật khẩu giới hạn 55 kí tự!";
        }
        return null;
    }

    public static Map<String, String> checkEditPassword(String oldPassword, String password, String confirmPassword) {
        Map<String, String> errMap = new HashMap<>();
        String errOldPassword;
        if ((errOldPassword = checkPassword(oldPassword)) != null) {
            errMap.put("errOldPassword", errOldPassword);
        }
        String errPassword;
        if ((errPassword = checkPassword(password)) != null) {
            errMap.put("errPassword", errPassword);
        }
        String errConfirmPassword;
        if ((errConfirmPassword = checkConfirmPassword(confirmPassword)) != null) {
            errMap.put("errConfirmPassword", errConfirmPassword);
        }
        return errMap;
    }

    public static Map<String, String> checkValidateUserName(String userName) {
        Map<String, String> errMap = new HashMap<>();
        String errUserName;
        if ((errUserName = checkUserName(userName)) != null) {
            errMap.put("errUserName", errUserName);
        }
        return errMap;
    }

    public static Map<String, String> checkValidateForgotPassword(String password, String confirmPassword) {
        Map<String, String> errMap = new HashMap<>();
        String errOldPassword;
        String errPassword;
        if ((errPassword = checkPassword(password)) != null) {
            errMap.put("errPassword", errPassword);
        }
        String errConfirmPassword;
        if ((errConfirmPassword = checkConfirmPassword(confirmPassword)) != null) {
            errMap.put("errConfirmPassword", errConfirmPassword);
        }
        return errMap;
    }
}
