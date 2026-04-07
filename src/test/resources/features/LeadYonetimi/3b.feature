@LeadPortalFlow3b
Feature: 3b - Gelen SMS onayli lead, isim farkli, kulup ayni
 #test.st5 den gıdılıcek
  # ─────────────────────────────────────────────────────────────────
  # 3b1 - mevcut SMS onaysiz | atanmamis | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b1 @3b
  Scenario Outline: 3b1 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onaysiz, atanmamis, gorev var/yok
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
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup       | expectedKaynak                      |
      | Ela | Kulta | 5981110531 | testlead3b1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | Steps: Success | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 3b2 - mevcut SMS onayLI | atanmamis | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b2 @3b
  Scenario Outline: 3b2 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onayLI, atanmamis, gorev var/yok

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
    And SMS kodu DBden cekilip OTP alanina girilir
    And OTP Dogrula butonuna basilir
    Then avm disi formunun gonderildigi dogrulanir


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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup       | expectedKaynak |
      | Ela | Kulta | 5972285895 | testlead3b2@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Brandium      | 42 Maslak     | System                  |              | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit 42 Maslak | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 3b3 - mevcut SMS onaysiz | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b3 @3b
  Scenario Outline: 3b3 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, gorev yok
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110533 | testlead3b3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | steps: Success | Satış Görüşmesi | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 3b4 - mevcut SMS onaysiz | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b4 @3b
  Scenario Outline: 3b4 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, telefon gorevi var
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi              | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110534 | testlead3b4@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | steps: Success | Telefon Aramasi Planla | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 3b5 - mevcut SMS onayLI | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b5 @3b
  Scenario Outline: 3b5 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onayLI, atali, telefon gorevi var
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi              | nedenKodu           | expectedKaynak                      |
      | Ela | Kulta | 5981110535 | testlead3b5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | Steps: Success | Telefon Aramasi Planla | Alotech Ulasilamadi | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 3b6 - mevcut SMS onaysiz | atali | randevu/tur gorevi var
  #Yavuza sorulacak // TODO
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b6 @3b
  Scenario Outline: 3b6 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, randevu/tur gorevi var
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi      | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110536 | testlead3b6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | steps: Success | Randevu Planla | Randevu Ayarlandı | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 3b7 - mevcut SMS onayLI | atali | randevu/tur gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b7 @3b
  Scenario Outline: 3b7 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onayLI, atali, randevu/tur gorevi var
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
    And avm disi formunda kulup "42 Maslak" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And SMS kodu DBden cekilip OTP alanina girilir
    And OTP Dogrula butonuna basilir
    Then avm disi formunun gonderildigi dogrulanir


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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110537 | testlead3b7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  |              | Satış Görüşmesi | Alotech Ulasilamadi | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 3b8 - mevcut SMS onaysiz | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b8
  Scenario Outline: 3b8 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110538 | testlead3b8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  | Steps: Information | Tur Olustur | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 3b9 - mevcut SMS onayLI | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b9 @3b
  Scenario Outline: 3b9 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When Telefon ile arama yapilir "<gsmNo>"
    And "<gorevTipi>" gorevi atanir


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
    And SMS kodu DBden cekilip OTP alanina girilir
    And OTP Dogrula butonuna basilir
    Then avm disi formunun gonderildigi dogrulanir


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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110539 | testlead3b9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Brandium      | 42 Maslak     | System                  |              | Satış Görüşmesi | Alotech Ulasilamadi | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 3b10 - mevcut SMS onayLI | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @3b10 @3b
  Scenario Outline: 3b10 - Gelen SMS onayLI, isim farkli, kulup ayni, mevcut SMS onayLI, atali, gorev yok
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
    And iki saniye bekler
    Then Ilk satirda ad "<expectedAd>" gorunur
    And Ilk satirda soyad "<expectedSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | expectedKaynak |
      | Ela | Kulta | 5981110540 | testlead3b10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Brandium    | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Brandium      | 42 Maslak     | System                  | Steps: Addon | Website        |