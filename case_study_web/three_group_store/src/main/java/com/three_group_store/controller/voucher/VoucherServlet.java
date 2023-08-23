package com.three_group_store.controller.voucher;

import com.three_group_store.model.voucher.Voucher;
import com.three_group_store.service.voucher.IVoucherService;
import com.three_group_store.service.voucher.VoucherService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VoucherServlet", value = "/vouchers")
public class VoucherServlet extends HttpServlet {
    private IVoucherService voucherService = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showNewForm(request, response);
                break;
            case "delete":
                deleteVoucher(request, response);
                break;
            case "update":
                updateVoucherById(request, response);
                break;
            case "search":
                searchByName(request, response);
                break;
            case "increase":
                sortIncreaseByRate(request, response);
                break;
            case "decrease":
                sortDecreaseByRate(request, response);
                break;
            default:
                listVoucher(request, response);
                break;
        }
    }

    private void sortDecreaseByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Voucher> voucherList = null;
        try {
            voucherList = voucherService.orderByDecreaseRate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("voucherList", voucherList);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/list.jsp");
        requestDispatcher.forward(request, response);
    }

    private void sortIncreaseByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Voucher> voucherList = null;
        try {
            voucherList = voucherService.orderByIncreaseRate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("voucherList", voucherList);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/list.jsp");
        requestDispatcher.forward(request, response);
    }

    private void updateVoucherById(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Voucher voucher = voucherService.selectVoucher(id);
        RequestDispatcher requestDispatcher;
        if (voucher == null) {
            requestDispatcher = request.getRequestDispatcher("voucher/error.jsp");
        } else {
            request.setAttribute("voucher", voucher);
            requestDispatcher = request.getRequestDispatcher("voucher/update.jsp");
        }
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void searchByName(HttpServletRequest request, HttpServletResponse response) {
        String searchName = request.getParameter("searchName");
        List<Voucher> voucherList = voucherService.searchByName(searchName);
        System.out.println(voucherList);
        if (voucherList != null) {
            request.setAttribute("voucherList", voucherList);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/search.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            String msg = "Không tìm thấy";
            request.setAttribute("msg", msg);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/search.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/create.jsp");
        requestDispatcher.forward(request, response);
    }

    private void listVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Voucher> voucherList = voucherService.selectAllVoucher();
        request.setAttribute("voucherList", voucherList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("voucher/list.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                insertVoucher(request, response);
                break;
            case "update":
                updateVoucher(request, response);
                break;
        }
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherService.deleteVoucher(id);
        try {
            response.sendRedirect("/vouchers");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        float rate = Float.parseFloat(request.getParameter("rate"))/100;
        Voucher voucher = new Voucher(id, name, rate);
        voucherService.updateVoucher(voucher);
        response.sendRedirect("/vouchers");
    }

    private void insertVoucher(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        float rate = Float.parseFloat(request.getParameter("rate"))/100;
        boolean checkVoucherName = voucherService.checkVoucherByName(name);
        boolean checkVoucherRate = voucherService.checkVoucherByRate(rate);
        Voucher voucher = new Voucher(name,rate);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("voucher/create.jsp");
        if (name=="" || rate==0){
            request.setAttribute("message", "Voucher mới không được tạo do trùng tên hoặc trùng rate với voucher hiện có");
        } else if (checkVoucherName && checkVoucherRate) {
            request.setAttribute("message", "Một voucher mới đã tạo thành công!");
            voucherService.insertVoucher(voucher);
        } else if (checkVoucherName == false && checkVoucherRate ==false){
            request.setAttribute("message", "Voucher mới không được tạo do trùng tên hoặc trùng rate với voucher hiện có");
        }
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
