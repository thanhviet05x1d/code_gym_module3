package com.three_group_store.controller.product;

import com.three_group_store.model.account.Account;
import com.three_group_store.model.product.Product;
import com.three_group_store.model.product.ProductType;
import com.three_group_store.repository.order.Cart;
import com.three_group_store.service.product.IProductService;
import com.three_group_store.service.product.ProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductServlet", value = "/ProductServlet")
public class ProductServlet extends HttpServlet {
    private IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "productManagement":
                showManagementList(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "save":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "view":
                viewProduct(request, response);
                break;
            case "sortAsc":
                sortAsc(request,response);
                break;
            case "sortDesc":
               sortDesc(request,response);
                break;
            case "search":
                searchProduct(request, response);
                break;
            default:
                showList(request, response);
                break;
        }
    }

    private void searchProduct(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        int range = Integer.parseInt(request.getParameter("range"));
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        List<Product> products = new ArrayList<>();
        RequestDispatcher dispatcher;
        if (name != "") {
            List<Product> product1 = productService.searchByName(name);
            List<Product> product2 = productService.searchByPrice(range);
            for (int i = 0; i < product1.size(); i++) {
                for (int j = 0; j < product2.size(); j++) {
                    if (product1.get(i).equals(product2.get(j))) {
                        products.add(product1.get(i));
                    }
                }
            }
        } else {
            products = productService.searchByPrice(range);
        }
        request.setAttribute("productList", products);
        request.setAttribute("name", name);
        if (products.isEmpty()) {
            request.setAttribute("message", "Sản phẩm bạn tìm kiếm không tồn tại!");
        } else {
            request.setAttribute("productList", products);
        }
        if (account == null) {
            dispatcher = request.getRequestDispatcher("home.jsp");
        } else if (account.getRoleName().equals("admin")) {
            dispatcher = request.getRequestDispatcher("/product/list.jsp");
        } else {
            dispatcher = request.getRequestDispatcher("home.jsp");
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sortAsc(HttpServletRequest request, HttpServletResponse response) {
        List<Product> productList = productService.sortAscByPrice();
        request.setAttribute("productList", productList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sortDesc(HttpServletRequest request, HttpServletResponse response) {
        List<Product> productList = productService.sortDescByPrice();
        request.setAttribute("productList", productList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.searchById(id);
        request.setAttribute("product", product);
        RequestDispatcher dispatcher = request.getRequestDispatcher("product/view.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) {
        List<ProductType> productTypes = productService.showTypeList();
        request.setAttribute("productTypes", productTypes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("product/create.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.searchById(id);
        List<ProductType> productTypes = productService.showTypeList();
        request.setAttribute("productTypes", productTypes);
        request.setAttribute("product", product);
        request.setAttribute("id", id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("product/edit.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.remove(id);
        try {
            response.sendRedirect("ProductServlet?action=productManagement");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response) {
        int page = 1;
        int recordsPerPage = 8;
        if (request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));
        List<Product> products = productService.getAllPaging(recordsPerPage, (page - 1) * recordsPerPage);
        List<Product> productList = productService.showList();

        int noOfRecords = productList.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        RequestDispatcher dispatcher;
        if (productList.isEmpty()) {
            dispatcher = request.getRequestDispatcher("home.jsp");
        } else {
            request.setAttribute("productList", products);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalQuantity", Cart.totalQuantity);
            dispatcher = request.getRequestDispatcher("home.jsp");
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showManagementList(HttpServletRequest request, HttpServletResponse response) {
        List<Product> productList = productService.showList();
        RequestDispatcher dispatcher;
        if (productList.isEmpty()) {
            dispatcher = request.getRequestDispatcher("product/list.jsp");
        } else {
            request.setAttribute("productList", productList);
            dispatcher = request.getRequestDispatcher("product/list.jsp");
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                addProduct(request, response);
                break;
            case "save":
                saveProduct(request, response);
                break;
            default:
                break;
        }
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = 0;
        if (request.getParameter("price") != null && !request.getParameter("price").isEmpty()) {
            System.out.println(request.getParameter("price"));
            price = Double.parseDouble(request.getParameter("price"));
        }
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        int inventory = 0;
        if (request.getParameter("inventory") != null && !request.getParameter("inventory").isEmpty()) {
            inventory = Integer.parseInt(request.getParameter("inventory"));
        }

        String imgPath = request.getParameter("imgPath");
        Product product = new Product(id, name, price, description, type, inventory, imgPath);
        Map<String, String> errMap = productService.save(product);
        if (errMap.isEmpty()) {
            try {
                response.sendRedirect("/ProductServlet?action=productManagerment");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            List<ProductType> productTypes = productService.showTypeList();
            request.setAttribute("productTypes", productTypes);
            request.setAttribute("product", product);
            request.setAttribute("errors", errMap);
            try {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/product/edit.jsp");
                dispatcher.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        double price = 0;
        if (request.getParameter("price") != null && !request.getParameter("price").isEmpty()) {
            System.out.println(request.getParameter("price"));
            price = Double.parseDouble(request.getParameter("price"));
        }
        String description = request.getParameter("description");
        String type = request.getParameter("type");
        int inventory = 0;
        if (request.getParameter("inventory") != null && !request.getParameter("inventory").isEmpty()) {
            inventory = Integer.parseInt(request.getParameter("inventory"));
        }

        String imdPath = request.getParameter("imgPath");
        Product product = new Product(name, price, description, type, inventory, imdPath);
        Map<String, String> errMap = productService.add(product);

        if (errMap.isEmpty()) {
            try {
                response.sendRedirect("/ProductServlet?action=productManagerment");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            List<ProductType> productTypes = productService.showTypeList();
            request.setAttribute("productTypes", productTypes);
            request.setAttribute("product", product);
            request.setAttribute("errors", errMap);
            try {
                RequestDispatcher dispatcher = request.getRequestDispatcher("product/create.jsp");
                dispatcher.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }



}
