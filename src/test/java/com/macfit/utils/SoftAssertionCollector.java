package com.macfit.utils;

import java.util.ArrayList;
import java.util.List;

public class SoftAssertionCollector {

    private static final ThreadLocal<List<String>> errors = ThreadLocal.withInitial(ArrayList::new);

    public static void add(String message) {
        errors.get().add(message);
    }

    public static boolean hasErrors() {
        return !errors.get().isEmpty();
    }

    public static String getReport() {
        List<String> list = errors.get();
        StringBuilder sb = new StringBuilder("\n--- SOFT ASSERTION FAILURES ---\n");
        for (int i = 0; i < list.size(); i++) {
            sb.append((i + 1)).append(") ").append(list.get(i)).append("\n");
        }
        return sb.toString();
    }

    public static void clear() {
        errors.get().clear();
    }
}
