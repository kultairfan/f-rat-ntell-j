package com.macfit.utils;

import java.util.Random;

public class TestData {

    private static final Random random = new Random();

    public static String generatePhone() {
        int num = 10000000 + random.nextInt(90000000);
        return "59" + num;
    }
}