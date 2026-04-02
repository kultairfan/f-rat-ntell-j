@LeadPortalFlow2b
Feature: 2b - Gelen SMS onayLI lead, isim ayni, kulup ayni
   #test.st5 den gıdılıcek
  # Kural: Gelen lead SMS onayLI | Mevcut isim ayni | Kulup AYNI
  # Kulup AYNI oldugu icin portalKulup = 2a ile ayni
  # 2b8-2b9 disinda owner genel olarak korunur, 2b8-2b9'da System beklenir

  # ─────────────────────────────────────────────────────────────────
  # 2b1 - mevcut SMS onaysiz | atanmamis | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b1 @2b
  Scenario Outline: 2b1 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onaysiz, atanmamis, gorev var/yok

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
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye listesine gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup       |
      | Ela | kulta | 5981110531 | testlead2b1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | System                  | Steps: PhoneNumber | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak |

  # ─────────────────────────────────────────────────────────────────
  # 2b2 - mevcut SMS onayLI | atanmamis | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b2 @2b
  Scenario Outline: 2b2 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onayLI, atanmamis, gorev var/yok

    When "<vucutUrl>" portali acilir ve devam edilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<vucutKulup>" secilir
    And Vucut form bilgileri girilir ad "<ad>" soyad "<soyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Vucut formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup       |
      | Ela | kulta | 5972285895 | testlead2b2@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | test.st5                  |  | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak |

  # ─────────────────────────────────────────────────────────────────
  # 2b3 - mevcut SMS onaysiz | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b3 @2b
  Scenario Outline: 2b3 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, gorev yok
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
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110533 | testlead2b3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | steps: Success | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b4 - mevcut SMS onaysiz | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b4 @2b
  Scenario Outline: 2b4 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, telefon gorevi var
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
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi              | nedenKodu           |
      | Ela | kulta | 5981110534 | testlead2b4@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | steps: Success | Telefon Aramasi Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b5 - mevcut SMS onayLI | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b5 @2b
  Scenario Outline: 2b5 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onayLI, atali, telefon gorevi var
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
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi              | nedenKodu           |
      | Ela | kulta | 5981110535 | testlead2b5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: PhoneNumber | Telefon Aramasi Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b6 - mevcut SMS onaysiz | atali | randevu/tur gorevi var
  #Yavuza sorulacak // TODO
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b6
  Scenario Outline: 2b6 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, randevu/tur gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And iki saniye bekler
    Then Olympus dashboard navigate edilir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir


    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110536 | testlead2b6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: Information | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b7 - mevcut SMS onayLI | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b7 @2b
  Scenario Outline: 2b7 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onayLI, atali, randevu/tur gorevi var
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
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi      | nedenKodu           |
      | Ela | kulta | 5981110537 | testlead2b7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | Steps: PhoneNumber | Randevu Planla | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b8 - mevcut SMS onaysiz | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b8 @2b
  Scenario Outline: 2b8 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir
    And iki saniye bekler
    Then Olympus dashboard navigate edilir

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi   | nedenKodu           |
      | Ela | kulta | 5981110538 | testlead2b8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | test.st5                | steps: Success | Tur Olustur | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b9 - mevcut SMS onayLI | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b9
  Scenario Outline: 2b9 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
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
    And Portal devam butonuna basilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi       | nedenKodu           |
      | Ela | kulta | 5981110539 | testlead2b9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | System                  | Steps: Success | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 2b10 - mevcut SMS onayLI | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @2b10 @2b
  Scenario Outline: 2b10 - Gelen SMS onayLI, isim ayni, kulup ayni, mevcut SMS onayLI, atali, gorev yok
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
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags       |
      | Ela | kulta | 5981110540 | testlead2b10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | System                  | Steps: Clubs |