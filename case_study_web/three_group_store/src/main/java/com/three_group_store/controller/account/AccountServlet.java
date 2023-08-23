package com.three_group_store.controller.account;

import com.three_group_store.utils.account.Email;
import com.three_group_store.model.account.Account;
import com.three_group_store.model.customer.Customer;
import com.three_group_store.service.account.AccountService;
import com.three_group_store.service.account.IAccountService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;

import static com.sun.org.apache.xalan.internal.xsltc.compiler.Constants.CHARACTERS;

@WebServlet(name = "AccountServlet", value = "/accountServlet")
public class AccountServlet extends HttpServlet {
    private static IAccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                showLoginForm(request, response);
                break;
            case "logout":
                logoutAccount(request, response);
                break;
            case "create":
                showCreateUserForm(request, response);
                break;
            case "userList":
                displayUserList(request, response);
                break;
            case "register":
                showRegisterForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "forgotPassword":
                showCheckUserNameForm(request, response);
                break;
            case "checkCode":
                showCheckCodeForm(request, response);
                break;
            default:
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/home.jsp");
                requestDispatcher.forward(request, response);
        }
    }

    private void showCheckCodeForm(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        Map<String, String> errMap = accountService.checkValidateUserName(userName);
        RequestDispatcher requestDispatcher;
        if (errMap.isEmpty()) {
            Account account = accountService.findByUserName(userName);
            if (account != null) {
                Customer customer = accountService.findCustomerByUserName(userName);
                if (customer != null) {
                    Random random = new Random();
                    StringBuilder code = new StringBuilder(4);
                    for (int i = 0; i < 4; i++) {
                        code.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
                    }
                    Email.sendEmail(customer.getEmail(), System.currentTimeMillis() + "", String.valueOf(code));

                    request.setAttribute("code", String.valueOf(code));
                    request.setAttribute("userName", userName);
                    requestDispatcher = request.getRequestDispatcher("/account/change_password.jsp");
                } else {
                    request.setAttribute("userName", userName);
                    request.setAttribute("msg", "Tài khoản chưa đăng kí mail!");
                    requestDispatcher = request.getRequestDispatcher("/account/check_code.jsp");
                }
            } else {
                request.setAttribute("userName", userName);
                request.setAttribute("msg", "Tài khoản không tồn tại!");
                requestDispatcher = request.getRequestDispatcher("/account/check_code.jsp");

            }
        } else {
            request.setAttribute("userName", userName);
            request.setAttribute("errMap", errMap);
            requestDispatcher = request.getRequestDispatcher("/account/check_code.jsp");

        }
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showCheckUserNameForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher("account/check_code.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect("/account/edit.jsp");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void displayUserList(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher;
        if (!session.isNew()) {
            Account account = (Account) session.getAttribute("account");
            if (account.getRoleName().equals("admin")) {
                List<Account> accountList = accountService.getAllUser();
                if (accountList != null) {
                    request.setAttribute("accountList", accountList);
                } else {
                    request.setAttribute("msg", "Không có tài khoản nào ở trong danh sách");
                }
                requestDispatcher = request.getRequestDispatcher("/account/list_user.jsp");

            } else {
                request.setAttribute("msg", "Xin lỗi, bạn không có quyền vào mục này!");
                requestDispatcher = request.getRequestDispatcher("/account/error.jsp");
            }
        } else {
            requestDispatcher = request.getRequestDispatcher("/ProductServlet");
        }
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showCreateUserForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect("/account/create_user.jsp");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showLoginForm(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/account/login.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void logoutAccount(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
        }
        try {
            response.sendRedirect("/ProductServlet");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                loginAccount(request, response);
                break;
            case "createUser":
                createUser(request, response);
                break;
            case "editUser":
                editPassword(request, response);
                break;
            case "checkForgotPassword":
                checkForgotPassword(request, response);
                break;

        }
    }
    private void editPassword(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String oldPassword = request.getParameter("oldPassword");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        Map<String, String> errMap = accountService.checkValidatePassword(oldPassword, password, confirmPassword);
        if (errMap.isEmpty()) {
            errMap = accountService.editUser(userName, oldPassword, password, confirmPassword);
        }
        request.setAttribute("errMap", errMap);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/account/edit.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void checkForgotPassword(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String code = request.getParameter("code");
        String inputCode = request.getParameter("inputCode");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        Map<String, String> errMap = accountService.checkValidateForgotPassword(password, confirmPassword);
        RequestDispatcher requestDispatcher;
        if (errMap.isEmpty()) {
            if (code.equals(inputCode) && password.equals(confirmPassword)) {
                accountService.forgotPassword(userName, password);
                request.setAttribute("mess", "Đã đổi mật khẩu thành công, hãy đăng nhập!");
                requestDispatcher = request.getRequestDispatcher("/account/login.jsp");
            } else {
                request.setAttribute("password", password);
                request.setAttribute("confirmPassword", confirmPassword);
                request.setAttribute("inputCode", inputCode);
                if (!code.equals(inputCode) || inputCode == null) {
                    request.setAttribute("mess", "Mã không chính xác!");
                }
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("msg", "Mật khẩu không khớp");
                }
                request.setAttribute("userName", userName);
                request.setAttribute("code", code);
                request.setAttribute("userName", userName);
                requestDispatcher = request.getRequestDispatcher("/account/change_password.jsp");
            }
        } else {
            request.setAttribute("userName", userName);
            request.setAttribute("errMap", errMap);
            requestDispatcher = request.getRequestDispatcher("/account/change_password.jsp");
        }
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");

        accountService.deleteUser(userName);
        RequestDispatcher requestDispatcher;

        request.setAttribute("msg", "Đã xoá tài khoản " + userName);
        requestDispatcher = request.getRequestDispatcher("/accountServlet?action=userList");

        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        Map<String, String> errMap = accountService.checkValidateAccount(userName, password, confirmPassword);

        RequestDispatcher requestDispatcher;

        if (errMap.isEmpty()) {
            boolean rowUpdate;
            String msgSigin = "";
            if (!accountService.checkUserName(userName)) {
                if (password.equals(confirmPassword)) {
                    rowUpdate = accountService.addUser(new Account(userName, password, "user"));
                    if (rowUpdate) {
                        request.setAttribute("userName", userName);
                        requestDispatcher = request.getRequestDispatcher("customer/create.jsp");
                    } else {
                        msgSigin = "Đăng kí thất bại, vui lòng thử lại!";
                        requestDispatcher = request.getRequestDispatcher("/account/create_user.jsp");
                    }
                } else {
                    request.setAttribute("msg", "Mật khẩu không khớp,vui lòng nhập lại!");
                    requestDispatcher = request.getRequestDispatcher("/account/create_user.jsp");
                }

            } else {
                errMap.put("errUserName", "Tên tài khoản trùng lặp, vui lòng chọn tên khác!");
                request.setAttribute("errMap", errMap);
                requestDispatcher = request.getRequestDispatcher("/account/create_user.jsp");
            }
            request.setAttribute("userName", userName);
            request.setAttribute("password", password);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("msgErr", msgSigin);
        } else {
            request.setAttribute("userName", userName);
            request.setAttribute("password", password);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("errMap", errMap);
            requestDispatcher = request.getRequestDispatcher("/account/create_user.jsp");
        }

        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void loginAccount(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        Map<String, String> errMap = accountService.checkValidateLogin(userName, password);

        if (errMap.isEmpty()) {
            Account account = accountService.login(userName, password);
            System.out.println(account);
            if (account != null) {
                HttpSession session = request.getSession();
                session.setAttribute("account", account);
                Cookie userNameCookie = new Cookie("userName", userName);
                Cookie passwordCookie = new Cookie("password", password);
                Cookie rememberMeCookie = new Cookie("rememberMe", rememberMe);
                if (rememberMe != null) {
                    userNameCookie.setMaxAge(60 * 60 * 24 * 30);
                    passwordCookie.setMaxAge(60 * 60 * 24 * 30);
                    rememberMeCookie.setMaxAge(60 * 60 * 24 * 30);
                }
                response.addCookie(userNameCookie);
                response.addCookie(passwordCookie);
                response.addCookie(rememberMeCookie);

                Customer customer = accountService.findCustomerByUserName(userName);
                if (customer == null && !account.getRoleName().equals("admin")) {
                    request.setAttribute("userName", userName);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("customer/create.jsp");
                    try {
                        requestDispatcher.forward(request, response);
                    } catch (ServletException e) {
                        throw new RuntimeException(e);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    try {
                        response.sendRedirect("/ProductServlet");
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
            } else {
                request.setAttribute("msg", "Sai mật khẩu hoặc tài khoản không tồn tại!");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("account/login.jsp");
                try {
                    requestDispatcher.forward(request, response);
                } catch (ServletException e) {
                    throw new RuntimeException(e);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        } else {
            request.setAttribute("errMap", errMap);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("account/login.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
