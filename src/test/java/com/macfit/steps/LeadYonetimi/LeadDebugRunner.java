package com.macfit.steps.LeadYonetimi;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import io.cucumber.core.internal.com.fasterxml.jackson.databind.ObjectMapper;

public class LeadDebugRunner {

    // ======================================================
    // CONFIG
    // ======================================================
    private static final String API_URL = "https://olympusdev-leadstimeline.marsathletic.com/api/Leads/create-lead";

    // DB
    private static final String DB_URL  = "jdbc:mysql://10.10.100.81:3306/?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "devApp";
    private static final String DB_PASS = "tV753knM3Ppr";

    // BODY1 sonrası durdur
    private static final boolean PAUSE_AFTER_BODY1 = true;

    private static final ObjectMapper MAPPER = new ObjectMapper();

    // ======================================================
    // MODELS
    // ======================================================
    static class Scenario {
        String id;
        Map<String, Object> body1;
        Map<String, Object> body2;

        Scenario(String id, Map<String, Object> body1, Map<String, Object> body2) {
            this.id = id;
            this.body1 = body1;
            this.body2 = body2;
        }
    }

    static class HttpRes {
        int code;
        String body;
        HttpRes(int code, String body) { this.code = code; this.body = body; }
    }

    static class LeadSourceHistoryRow {
        Integer sourceId;
        Integer clubId;
        Boolean isSmsApproved;
        String correlationId;

        @Override public String toString() {
            return "TL(SourceId=" + sourceId +
                    ", ClubId=" + clubId +
                    ", IsSmsApproved=" + isSmsApproved +
                    ", CorrelationId=" + correlationId + ")";
        }
    }

    // ======================================================
    // MAIN
    // ======================================================
    public static void main(String[] args) throws Exception {
        List<Scenario> scenarios = buildScenarios();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

            for (Scenario sc : scenarios) {
                System.out.println("\n================================");
                System.out.println("CASE=" + sc.id + " | GSM=" + sc.body1.get("gsmNo") + " | Email=" + sc.body1.get("email"));

                // Guard: body2.isSmsApproved boolean olmalı
                Object b2Sms = sc.body2.get("isSmsApproved");
                if (!(b2Sms instanceof Boolean)) {
                    throw new IllegalStateException(sc.id + " body2.isSmsApproved boolean değil (true/false olmalı). actual=" + b2Sms);
                }

                // -------- API#1
                HttpRes r1 = postJson(API_URL, MAPPER.writeValueAsString(sc.body1));
                if (r1.code != 200 && r1.code != 201) {
                    System.out.println(sc.id + " API#1 FAIL code=" + r1.code + " body=" + r1.body);
                    return;
                }
                System.out.println(sc.id + " API#1 OK code=" + r1.code + " resp=" + safeTrim(r1.body));

                LeadSourceHistoryRow tl1 = pollLatestLeadSourceHistory(conn,
                        String.valueOf(sc.body1.get("email")),
                        String.valueOf(sc.body1.get("gsmNo")),
                        10, 800
                );
                if (tl1 != null) System.out.println(sc.id + " TL#1 " + tl1);

                // ✅ DEBUG DURMA NOKTASI
                // Eclipse’te buraya breakpoint koyabilirsin.
                if (PAUSE_AFTER_BODY1) {
                    manualPause("\n" +
                            "CASE=" + sc.id + "\n" +
                            "BODY1 gönderildi. Şimdi DB’de manuel işlemini yap.\n" +
                            "GSM=" + sc.body1.get("gsmNo") + "\n" +
                            "Email=" + sc.body1.get("email") + "\n" +
                            "TL1.Corr=" + (tl1 != null ? tl1.correlationId : "NULL") + "\n"
                    );
                }

                // -------- API#2
                HttpRes r2 = postJson(API_URL, MAPPER.writeValueAsString(sc.body2));
                if (r2.code != 200 && r2.code != 201) {
                    System.out.println(sc.id + " API#2 FAIL code=" + r2.code + " body=" + r2.body);
                    return;
                }
                System.out.println(sc.id + " API#2 OK code=" + r2.code + " resp=" + safeTrim(r2.body));

                LeadSourceHistoryRow tl2 = pollLatestLeadSourceHistory(conn,
                        String.valueOf(sc.body2.get("email")),
                        String.valueOf(sc.body2.get("gsmNo")),
                        10, 800
                );
                if (tl2 != null) System.out.println(sc.id + " TL#2 " + tl2);

                System.out.println(sc.id + " DONE");
            }
        }
    }

    // ======================================================
    // SCENARIOS (1A1..1A9) - senin attığın body1/body2 aynen
    // ======================================================
    private static List<Scenario> buildScenarios() {
        List<Scenario> list = new ArrayList<>();

        list.add(new Scenario("1A1",
                body(100, 73, "1a1testb", "1a1t", "5402266401", "kulta@test", false,
                        sub("1a1test", "1astest")),
                body(102, 74, "1a1testb", "1a1t", "5402266401", "kulta@test", false,
                        sub("1a1test", "1astest"))
        ));

        list.add(new Scenario("1A2",
                body(100, 73, "1a2t", "1a2t", "5402266402", "kulta@test", true,
                        sub("1a2test", "1a2stest")),
                body(102, 74, "1a2t", "1a2t", "5402266402", "kulta@test", false,
                        sub("1a2test", "1a2stest"))
        ));

        list.add(new Scenario("1A3",
                body(100, 73, "1a3t", "1a3t", "5402266403", "kulta@test", false,
                        sub("1a3test", "1a3stest")),
                body(102, 74, "1a3t", "1a3t", "5402266403", "kulta@test", false,
                        sub("1a3test", "1a3stest"))
        ));

        list.add(new Scenario("1A5",
                body(100, 73, "1a5t", "1a5t", "5402266405", "kulta@test", true,
                        sub("1a5test", "1a5stest")),
                body(102, 74, "1a5t", "1a5t", "5402266405", "kulta@test", false,
                        sub("1a5test", "1a5stest"))
        ));

        list.add(new Scenario("1A6",
                body(100, 73, "1a6t", "1a6t", "5402266406", "kulta@test", false,
                        sub("1a6test", "1a6stest")),
                body(102, 74, "1a6t", "1a6t", "5402266406", "kulta@test", false,
                        sub("1a6test", "1a6stest"))
        ));

        list.add(new Scenario("1A7",
                body(100, 73, "1a7t", "1a7t", "5402266407", "kulta@test", true,
                        sub("1a7test", "1a7stest")),
                body(102, 74, "1a7t", "1a7t", "5402266407", "kulta@test", false,
                        sub("1a7test", "1a7stest"))
        ));

        list.add(new Scenario("1A8",
                body(100, 73, "1a8t", "1a8t", "5402266408", "kulta@test", false,
                        sub("1a8test", "1a8stest")),
                body(102, 74, "1a8t", "1a8t", "5402266408", "kulta@test", false,
                        sub("1a8test", "1a8stest"))
        ));

        list.add(new Scenario("1A9",
                body(100, 73, "1a9t", "1a9t", "5402266409", "kulta@test", true,
                        sub("1a9test", "1a9stest")),
                body(102, 74, "1a9t", "1a9t", "5402266409", "kulta@test", false,
                        sub("1a9test", "1a9stest"))
        ));

        return list;
    }

    // body helper (senin alanların aynı)
    private static Map<String, Object> body(int sourceId, int clubId,
                                           String name, String surname,
                                           String gsmNo, String email,
                                           boolean isSmsApproved,
                                           List<Map<String, String>> subdetails) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("sourceId", sourceId);
        m.put("clubId", clubId);
        m.put("name", name);
        m.put("surname", surname);
        m.put("gsmAreaCode", "90");
        m.put("gsmNo", gsmNo);
        m.put("email", email);
        m.put("birthDate", "2026-02-19T08:47:38.308Z");
        m.put("isSmsApproved", isSmsApproved);
        m.put("hasIysPermissonMail", true);
        m.put("hasIysPermissonCall", true);
        m.put("hasIysPermissonSms", true);
        m.put("leadSourceHistorySubdetails", subdetails);
        m.put("thirdPartyCreateDate", "2026-02-19T08:47:38.308Z");
        return m;
    }

    private static List<Map<String, String>> sub(String key, String value) {
        Map<String, String> kv = new LinkedHashMap<>();
        kv.put("key", key);
        kv.put("value", value);
        return Collections.singletonList(kv);
    }

    // ======================================================
    // HTTP
    // ======================================================
    private static HttpRes postJson(String url, String json) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.getBytes(StandardCharsets.UTF_8));
        }

        int code = conn.getResponseCode();
        InputStream is = (code >= 200 && code < 400) ? conn.getInputStream() : conn.getErrorStream();
        String body = readAll(is);
        return new HttpRes(code, body);
    }

    private static String readAll(InputStream is) throws IOException {
        if (is == null) return "";
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            return sb.toString();
        }
    }

    // ======================================================
    // DB (LeadSourceHistories latest)
    // ======================================================
    private static LeadSourceHistoryRow pollLatestLeadSourceHistory(Connection conn, String email, String gsmNo,
                                                                    int maxRetry, int delayMs) throws Exception {
        for (int i = 1; i <= maxRetry; i++) {
            LeadSourceHistoryRow row = getLatestLeadSourceHistory(conn, email, gsmNo);
            if (row != null) return row;
            Thread.sleep(delayMs);
        }
        return null;
    }

    private static LeadSourceHistoryRow getLatestLeadSourceHistory(Connection conn, String email, String gsmNo) throws Exception {
        String q = """
                SELECT SourceId, ClubId, IsSmsApproved, CorrelationId
                FROM LeadsTimeline.LeadSourceHistories
                WHERE EMail = ? OR GsmNo = ?
                ORDER BY CreateDate DESC
                LIMIT 1
                """;
        try (PreparedStatement ps = conn.prepareStatement(q)) {
            ps.setString(1, email);
            ps.setString(2, gsmNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                LeadSourceHistoryRow r = new LeadSourceHistoryRow();
                r.sourceId = rs.getObject("SourceId") != null ? rs.getInt("SourceId") : null;
                r.clubId = rs.getObject("ClubId") != null ? rs.getInt("ClubId") : null;
                r.isSmsApproved = rs.getObject("IsSmsApproved") != null ? rs.getBoolean("IsSmsApproved") : null;
                r.correlationId = rs.getString("CorrelationId");
                return r;
            }
        }
    }

    // ======================================================
    // PAUSE (debugger’sız da çalışır)
    // ======================================================
    private static void manualPause(String msg) throws IOException {
        System.out.println("\n==== MANUAL PAUSE ====");
        System.out.println(msg);
        System.out.println("Hazır olunca ENTER'a bas (BODY2 gönderilecek)...");
        new BufferedReader(new InputStreamReader(System.in)).readLine();
    }

    private static String safeTrim(String s) {
        if (s == null) return "null";
        s = s.trim();
        return s.length() > 300 ? s.substring(0, 300) + "..." : s;
    }
}