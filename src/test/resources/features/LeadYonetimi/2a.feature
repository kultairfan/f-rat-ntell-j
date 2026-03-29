@LeadPortalFlow
Feature: 2a - Gelen SMS onaysiz lead, isim ayni, kulup ayni

  # Kural: Gelen lead SMS onaysiz | Mevcut isim ayni | Kulup AYNI
  # Aksiyonlar: lead'e dokunma, source guncelle, status ret ise aktife cek, history at
  # Kulup AYNI oldugu icin portal kulup = Fisekhane (mevcut kulup)
  # NOT: Her Scenario Outline bagimsiz calisir. Biri patlarsa diger devam eder.

  # ─────────────────────────────────────────────────────────────────
  # 2a1 - sms onaysiz mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a1 @2a
  Scenario Outline: 2a1 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onaysiz, atanmamis, gorev var/yok
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu           |
      | Ela | kulta | 5981110521 | testlead2a1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: Information | Randevu Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a2 @2a
  Scenario Outline: 2a2 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onayLI, atanmamis, gorev var/yok
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi   | nedenKodu           |
      | Ela | kulta | 5981110522 | testlead2a2@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     |  test.st5               | Steps: Information | Tur Olustur | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a3 - sms onaysiz mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a3 @2a
  Scenario Outline: 2a3 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, gorev yok
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110523 | testlead2a3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: Information | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a4 - sms onaysiz mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a4  ## yavuza sorulacak // TODO
  Scenario Outline: 2a4 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, telefon gorevi var
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
    And JoinUs ulke "<ulke>" secilir
    And JoinUs formu doldurulur ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>" personelno "<personelNo>"
    And JoinUs onay butonuna basilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           |
      | Ela | kulta | 5981110524 | testlead2a4@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     |  test.st5                   | Steps: Information | Telefon Aramasi Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a5 - sms onayLI mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a5 @2a
  Scenario Outline: 2a5 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onayLI, atali, telefon gorevi var
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           |
      | Ela | kulta | 5981110525 | testlead2a5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: Information | Telefon Aramasi Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a6 - sms onaysiz mevcut | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a6 ### 1a6 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  Scenario Outline: 2a6 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur
    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And iki saniye bekler
    Then Olympus dashboard navigate edilir

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
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
  #görevleri kapat ıcın TODO
    # işlemtarihçesi için TODO

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110526 | testlead2a6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     |  test.st5              | Ücretsiz Ölçüm | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a7 - sms onayLI mevcut | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a7 @2a
  Scenario Outline: 2a7 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onayLI, atali, randevu/tur gorevi var
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu           |
      | Ela | kulta | 5981110527 | testlead2a7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: Information | Randevu Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a8 - sms onaysiz mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a8  ##Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım#### // TODO
  Scenario Outline: 2a8 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
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


    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur



    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi   | nedenKodu           |
      | Ela | kulta | 5981110528 | testlead2a8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     |  test.st5                   | Ücretsiz Ölçüm | Tur Olustur | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a9 - sms onayLI mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a9 @2a
  Scenario Outline: 2a9 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
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


    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir



    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110529 | testlead2a9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | System                  | Steps: Information  | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2a10 - sms onayLI mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @2a10 @2a
  Scenario Outline: 2a10 - Gelen SMS onaysiz, isim ayni, kulup ayni, mevcut SMS onayLI, atali, gorev yok
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

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags       |
      | Ela | kulta | 5981110530 | testlead2a10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     |  test.st5               | Steps: Information |
