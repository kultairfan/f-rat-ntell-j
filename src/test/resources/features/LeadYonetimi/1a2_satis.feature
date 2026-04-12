@LeadPortalFlow1a
Feature: 1a2 - Gelen SMS onaysiz lead, isim ayni, kulup farkli

  @withoutOTP @1a1test
  Scenario Outline: 1a1test - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atanmamis, gorev var/yok

    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye listesine gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup             |
      | Ela | kulta | 5981110501 | testlead1a1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | System                  | Adım: Telefon No | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç  |


  # ─────────────────────────────────────────────────────────────────
  # 1a2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a2test
  Scenario Outline: 1a2test - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atanmamis, gorev var/yok

    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye listesine gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | portalDogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup            |
      | Ela | kulta | 5911110117 | testlead1a2@hotmail.com | 18.09.2000        | dijital-uyelik-formu   | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 5941412    | 42 Maslak     | System                  | Adım: Kulüp Seçme | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç |
