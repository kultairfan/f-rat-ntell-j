Feature: Avm disi etkinlik

  @avm
  Scenario Outline: Avm disi etkinlik formu basariyla doldurulur
    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<ad>" girilir
    And avm disi formuna soyad "<soyad>" girilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<dogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "<kulup>" secilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    #And OTP dogrulamasi kapatilir
    And SMS kodu DBden cekilip OTP alanina girilir
     And OTP Dogrula butonuna basilir
    Then avm disi formunun gonderildigi dogrulanir





    Examples:
      | ad  | soyad | gsmNo      | email                   | dogumTarihi | sehir    | kulup     |
      | Ela | Kulta | 5981110541 | testlead3a1@hotmail.com | 18.09.2000  | İstanbul | 42 Maslak |