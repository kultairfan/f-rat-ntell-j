@LeadPortalFlow3a
Feature: 3a - Gelen SMS onaysiz lead, isim farkli, kulup ayni
  # test.st5 den gıdılıcek 42maslak bakıyor
  # ─────────────────────────────────────────────────────────────────
  # 3a1 - sms onaysiz mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a1 @3a
  Scenario Outline: 3a1 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onaysiz, atanmamis, gorev var/yok
    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Portal devam butonuna basilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    # bunu kaldırma ıhtımalın var eger exception verırse And Portal devam butonuna basilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye dashboarda gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup       | expectedKaynak                      |
      | Ela | Kulta | 5981110521 | testlead3a1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | Adım: Kişisel Bilgi | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 3a2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a2 @3a
  Scenario Outline: 3a2 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onayLI, atanmamis, gorev var/yok
    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Portal devam butonuna basilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

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

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup       | expectedKaynak |
      | Ela | Kulta | 5981110522 | testlead3a2@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Ela        | Kulta         | 42 Maslak     | System                  |              | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 3a3 - sms onaysiz mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a3 @3a
  Scenario Outline: 3a3 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110523 | testlead3a3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | Adım: Kişisel Bilgi | Satış Görüşmesi | Alotech Ulasilamadi | Ücretsiz Ölçüm |

  # ─────────────────────────────────────────────────────────────────
  # 3a4 - sms onaysiz mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a4 @3a
  Scenario Outline: 3a4 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, telefon gorevi var
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
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | gorevTipi              | nedenKodu           | expectedKaynak                      |
      | Ela | Kulta | 5981110524 | testlead3a4@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Brandium      | 42 Maslak     | System                  | Adım: Kişisel Bilgi | Telefon Aramasi Planla | Alotech Ulasilamadi | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 3a5 - sms onayLI mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a5 @3a
  Scenario Outline: 3a5 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onayLI, atali, telefon gorevi var
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
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | gorevTipi              | nedenKodu           | expectedKaynak                      |
      | Ela | Kulta | 5981110525 | testlead3a5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Ela        | Kulta         | 42 Maslak     | test.st5                | Adım: Kişisel Bilgi | Telefon Aramasi Planla | Alotech Ulasilamadi | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 3a6 - sms onaysiz mevcut | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a6 @3a ### 1a6 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  Scenario Outline: 3a6 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, randevu/tur gorevi var
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
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur
  #görevleri kapat ıcın TODO
    # işlemtarihçesi için TODO

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | gorevTipi      | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110526 | testlead3a6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Brandium      | 42 Maslak     | System                  | Adım: Kişisel Bilgi | Randevu Planla | Randevu Ayarlandı | Ücretsiz Ölçüm |

  # ─────────────────────────────────────────────────────────────────
  # 3a7 - sms onayLI mevcut | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a7 @3a
  Scenario Outline: 3a7 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onayLI, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<portalDogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "42 Maslak" secilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When ortak random gsm no ile telefon aramasi yapilir

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110527 | testlead3a7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Ela        | Kulta         | 42 Maslak     | test.st5                |              | Satış Görüşmesi | Randevu Ayarlandı | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 3a8 - sms onaysiz mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a8  ##Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım#### // TODO
  Scenario Outline: 3a8 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And JoinUs devam butonuna basilir
    And JoinUs ilk devam butonuna basilir
    And Portal sehir "<sehir>" secilir
    And JoinUs kulup "<portalKulup>" secilir
    And JoinUs paket secilir
    Then Portal OTP dogrulamasi atlanir
    And JoinUs ulke "<ulke>" secilir
    And JoinUs formu doldurulur ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>" personelno "<personelNo>"
    And JoinUs onay butonuna basilir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur



    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110528 | testlead3a8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Brandium      | 42 Maslak     | System                  | Ücretsiz Ölçüm | Tur Olustur | Alotech Ulasilamadi | Ücretsiz Ölçüm |

  # ─────────────────────────────────────────────────────────────────
  # 3a9 - sms onayLI mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a9 @3a
  Scenario Outline: 3a9 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onayLI, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And iki saniye bekler
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir

    When Avm disi etkinlik sayfasina gidilir
    And sayfa zoom out yapilir
    And avm disi formuna ad "<portalAd>" girilir
    And avm disi formuna soyad "<portalSoyad>" girilir
    And avm disi formuna eposta "<email>" girilir
    And avm disi formunda cinsiyet secilir
    And avm disi formuna dogum tarihi "<dogumTarihi>" girilir
    # And avm disi formunda sehir "<sehir>" secilir
    And avm disi formunda kulup "42 Maslak" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir


    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When ortak random gsm no ile telefon aramasi yapilir

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           | expectedAd | expectedSoyad | expectedKaynak |
      | Ela | Kulta | 5981110529 | testlead3a9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                |              | Satış Görüşmesi | Alotech Ulasilamadi | Ela        | Kulta         | AVM Etkinliği  |


  # ─────────────────────────────────────────────────────────────────
  # 3a10 - sms onayLI mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @3a10 @3a
  Scenario Outline: 3a10 - Gelen SMS onaysiz, isim farkli, kulup ayni, mevcut SMS onayLI, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

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

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    When Telefon ile arama yapilir "<gsmNo>"

    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags        | expectedKaynak |
      | Ela | Kulta | 5981110530 | testlead3a10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Ela        | Kulta         | 42 Maslak     | test.st5                | Adım: Kişisel Bilgi | Website        |
