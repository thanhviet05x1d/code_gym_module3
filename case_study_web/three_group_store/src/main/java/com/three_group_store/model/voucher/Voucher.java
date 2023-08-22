package com.three_group_store.model.voucher;

import java.util.Objects;

public class Voucher {
    private int id;
    private String name;
    private float rate;

    public Voucher() {
    }

    public Voucher(String name, float rate) {
        this.name = name;
        this.rate = rate;
    }
    public Voucher(int id, String name, float rate) {
        this.id = id;
        this.name = name;
        this.rate = rate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Voucher voucher = (Voucher) o;
        return id == voucher.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
