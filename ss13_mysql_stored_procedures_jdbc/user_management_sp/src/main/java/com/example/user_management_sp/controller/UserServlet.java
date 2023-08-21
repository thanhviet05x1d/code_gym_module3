package com.example.user_management_sp.controller;

import com.example.user_management_sp.model.User;
import com.example.user_management_sp.service.IUserService;
import com.example.user_management_sp.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/home")
public class UserServlet extends HttpServlet {
    IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                showDeleteForm(request, response);
                break;
            case "search":
                showSearchForm(request, response);
                break;
            case "sort":
                showSortForm(request, response);
                break;
            default:
                showListUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createUser(request, response);
                break;
            case "edit":
                editUser(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "search":
                searchByCountry(request, response);
                break;
            default:
                showListUsers(request, response);
                break;
        }
    }


    private void showListUsers(HttpServletRequest request, HttpServletResponse response) {
        try {

            List<User> userList = userService.displaySP();
            request.setAttribute("user", userList);
            request.getRequestDispatcher("/views/list.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher("views/create.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");

        User user = new User(name, email, country);
//        userService.createUser(user);
        userService.insertUserStore(user);
        try {
            request.setAttribute("user", user);
            request.setAttribute("message", "The User was Created");
            request.getRequestDispatcher("views/create.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
//        User user = userService.findId(id);
        User user = userService.getUserById(id);
        try {
            if (user == null) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            } else {
                request.setAttribute("user", user);
                request.getRequestDispatcher("views/edit.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");

        User user = userService.getUserById(id);
        try {
            if (user == null) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            } else {
                user.setName(name);
                user.setEmail(email);
                user.setCountry(country);
                userService.updateUserSP(id, user);

                request.setAttribute("user", user);
                request.setAttribute("message", "The user was updated");
                request.getRequestDispatcher("views/edit.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
//        User user = userService.findId(id);
        User user = userService.getUserById(id);
        try {
            if (user == null) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            } else {
                request.setAttribute("user", user);
                request.getRequestDispatcher("views/delete.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
//        User user = userService.findId(id);
        User user = userService.getUserById(id);

        try {
            if (user == null) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            } else {
//                userService.deleteUser(id);
                userService.deleteUserSP(id);
                response.sendRedirect("/home");
            }
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showSearchForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher("views/search.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void searchByCountry(HttpServletRequest request, HttpServletResponse response) {
        String country = request.getParameter("country");
        User user = userService.search(country);
        try {
            if (user == null) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            } else {
                request.setAttribute("user", user);
                request.getRequestDispatcher("views/search.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showSortForm(HttpServletRequest request, HttpServletResponse response) {
        List<User> userList = userService.sort();
        request.setAttribute("user", userList);
        try {
            request.getRequestDispatcher("views/list.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}

