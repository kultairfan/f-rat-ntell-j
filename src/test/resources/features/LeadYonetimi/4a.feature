@LeadPortalFlow4a
Feature: 4a - Gelen SMS onaysiz lead, isim farkli, kulup farkli

  # ─────────────────────────────────────────────────────────────────
  # 4a1 - sms onaysiz mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a1 @4a
  Scenario Outline: 4a1 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onaysiz, atanmamis, gorev var/yok

    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Portal devam butonuna basilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "42 Maslak" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
   # And SMS kodu DBden cekilip OTP alanina girilir
   # And OTP Dogrula butonuna basilir
   # Then avm disi formunun gonderildigi dogrulanir
    And OTP dogrulamasi kapatilir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye dashboarda gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup            | expectedKaynak |
      | Ela | Kulta | 5981110501 | testlead4a1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Automation    | 42 Maslak     | System                  |              | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 4a2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a2 @4a  # TODO satıs temsılcısıne atalı olmayacak joın us gıdılıcek vucut formuna gıdıcek
  Scenario Outline: 4a2 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onayLI, atanmamis, gorev var/yok

    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Portal devam butonuna basilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir
    And iki saniye bekler
    And iki saniye bekler
    And iki saniye bekler

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "42 Maslak" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir


    Given Olympus dashboard kontrole hazirlanir
    When Aday uye dashboarda gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur
    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup  | expectedSatisTemsilcisi | expectedTags   | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup            | expectedKaynak |
      | Ela | Kulta | 5998626473 | testlead4a2@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Ela        | Kulta         | Flatofis Haliç | System                  | steps: Success | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 4a3 - sms onaysiz mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a3 @4a
  Scenario Outline: 4a3 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi       | nedenKodu           | expectedKaynak  |
      | Ela | Kulta | 5981110503 | testlead4a3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Information | Satış Görüşmesi | Alotech Ulasilamadi | Vücut Analizi   |

  # ─────────────────────────────────────────────────────────────────
  # 4a4 - sms onaysiz mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  # ####################  BU SENARYO KALDIRILDI. ####################
  Scenario Outline: 4a4 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, telefon gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir

    Then Aday uye basariyla olusturulur
    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And JoinUs devam butonuna basilir
    And JoinUs ilk devam butonuna basilir
    And Portal sehir "<sehir>" secilir
    And JoinUs kulup "<portalKulup>" secilir
    And JoinUs paket secilir
    And JoinUs ulke "<ulke>" secilir
    And JoinUs formu doldurulur ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>" personelno "<personelNo>"
    And JoinUs onay butonuna basilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110504 | testlead4a4@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Automation    | 42 Maslak     | System                  | Steps: Information | Telefon Aramasi Planla | Alotech Ulasilamadi | Website        |

  # ─────────────────────────────────────────────────────────────────
  # 4a5 - sms onayLI mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a5 @4a
  Scenario Outline: 4a5 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onayLI, atali, telefon gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "Fişekhane" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye dashboarda gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110505 | testlead4a5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Ela        | Kulta         | 42 Maslak     | test.st5                | Steps: Kulübe gelen | Telefon Aramasi Planla | Alotech Ulasilamadi | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 4a6 - sms onaysiz mevcut | atali | randevu/tur/ Satış Görüşmesi  gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a6 @4a  ### 4a6 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  Scenario Outline: 4a6 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir


    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur
  #görevleri kapat ıcın TODO
    # işlemtarihçesi için TODO


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110506 | testlead4a6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Automation    | Altunizade    | System                  | Steps: Information | Randevu Planla | Randevu Ayarlandı | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 4a7 - sms onayLI mevcut | atali | randevu/tur/ Satış Görüşmesi  gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a7 @4a
  Scenario Outline: 4a7 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onayLI, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir


    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    Then Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur



    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup  | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu         | expectedKaynak                      |
      | Ela | Kulta | 5981110509 | testlead4a7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Ela        | Kulta         | Flatofis Haliç | System                  | Steps: PhoneNumber | Randevu Planla | Randevu Ayarlandı | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 4a8 - sms onaysiz mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  ### 4a8 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  @withoutOTP @4a8
  Scenario Outline: 4a8 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir

    Then Aday uye basariyla olusturulur
    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And JoinUs devam butonuna basilir
    And JoinUs ilk devam butonuna basilir
    And Portal sehir "<sehir>" secilir
    And JoinUs kulup "<portalKulup>" secilir
    And JoinUs paket secilir
    And JoinUs ulke "<ulke>" secilir
    And JoinUs formu doldurulur ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>" personelno "<personelNo>"
    And JoinUs onay butonuna basilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110508 | testlead4a8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Automation    | 42 Maslak     | System                  | Ücretsiz Ölçüm | Tur Olustur | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 4a9 - sms onayLI mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a9 @4a
  Scenario Outline: 4a9 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And iki saniye bekler
    Then Olympus dashboard navigate edilir

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "Fişekhane" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye dashboarda gidilir
    When ortak random gsm no ile telefon aramasi yapilir
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110527 | testlead4a9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Automation    | Fişekhane     | System                  |              | Satış Görüşmesi | Randevu Ayarlandı | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 4a10 - sms onayLI mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @4a10 @4a
  Scenario Outline: 4a10 - Gelen SMS onaysiz, isim farkli, kulup farkli, mevcut SMS onayLI, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "Fişekhane" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye dashboarda gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup           | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | expectedKaynak |
      | Ela | Kulta | 5981110510 | testlead4a10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | Afghanistan | 18.09.2000        | 5941412    | Ela        | Kulta         | 42 Maslak     | test.st5                | Steps: Kulübe gelen | AVM Etkinliği  |
