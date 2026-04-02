Feature: dijitalde kulup degistirme

  @dijital
  Scenario Outline: Kulup degistirme adımının eklenmesı ve degistirilmesi

    When  portali navigate ile acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<kulup>" secilir
    Then Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<dogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Examples:
      | ad  | soyad | gsmNo      | email                   | dogumTarihi | sehir    | kulup     |
      | Ela | Kulta | 5981110541 | testlead3a1@hotmail.com | 18.09.2000  | İstanbul | 42 Maslak |