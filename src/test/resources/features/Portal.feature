@PortalDirect
Feature: Portal direct flow

  @PortalDirect @portalDirect @withoutOTP
  Scenario Outline: Portal uzerinden direkt form doldurma
    Given "<portalUrl>" direct portal acilir
    When Portala example gsm numarasi girilir "<gsmNo>"
    And Direct portal sehir "<sehir>" secilir
    And Direct portal kulup "<kulup>" secilir
    And Direct portal devam butonuna basilir
    And Portal direct form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" gsmNo "<gsmNo>" dogumtarihi "<dogumTarihi>"
    And Direct portal kulup ikinci kez degistirilir
    And Direct portal formu gonderilir
    Then Direct portal OTP dogrulamasi atlanir

    Examples:
      | portalUrl            | gsmNo      | sehir    | kulup            | ad    | soyad | email                 | dogumTarihi |
      | dijital-uyelik-formu | 5992554772 | İstanbul | MACFit 42 Maslak | Irfan | Kulta | testportal1@gmail.com | 01.01.1995  |