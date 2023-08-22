package com.three_group_store.model.order;

import java.util.Objects;

public class OderDetail {
    private int orderDetailId;
    private int orderId;
    private int productId;
    private int productQuantity;

    public OderDetail() {
    }

    public OderDetail(int orderDetailId, int orderId, int productId, int productQuantity) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.productQuantity = productQuantity;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OderDetail that = (OderDetail) o;
        return orderDetailId == that.orderDetailId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderDetailId);
    }

}
