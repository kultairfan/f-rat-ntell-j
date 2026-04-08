@LeadPortalFlow4b
Feature: 4b - Gelen SMS onayli lead, isim farkli, kulup farkli

  # ─────────────────────────────────────────────────────────────────
  # 4b1 - sms onaysiz mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b1 @4b
  Scenario Outline: 4b1 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onaysiz, atanmamis, gorev var/yok
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
    And SMS kodu DBden cekilip OTP alanina girilir
    And OTP Dogrula butonuna basilir
    Then avm disi formunun gonderildigi dogrulanir
#    And OTP dogrulamasi kapatilir

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
      | Ela | Kulta | 5981110501 | testlead4b1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | 18.09.2000        | Katalon    | Automation    | 42 Maslak     | System                  |              | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 4b2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b2 @4b
  Scenario Outline: 4b2 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onayLI, atanmamis, gorev var/yok
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | vucutUrl            | vucutKulup            | expectedKaynak |
      | Ela | Kulta | 5998626473 | testlead4b2@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Katalon  | Automation  | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Katalon    | Automation    | 42 Maslak     | System                  |              | Tur Olustur | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç | AVM Etkinliği  |

  # 4b3 - sms onaysiz mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b3 @4b
  Scenario Outline: 4b3 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, gorev yok
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110503 | testlead4b3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Success | Satış Görüşmesi | Alotech Ulasilamadi | Ücretsiz Ölçüm  |

  # ─────────────────────────────────────────────────────────────────
  # 4b4 - sms onaysiz mevcut | atali | telefon gorevi var
  # ### YAVUZA SORULACAK ### TODO
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b4 #telefon görevi olması ıcın is sms approved 1 olması gerekmektedir. kaldırıldı
  Scenario Outline: 4b4 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, telefon gorevi var
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110514 | testlead4b4@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ece      | Kaya        | İstanbul | MACFit 42 Maslak | 18.09.2000        | Ece        | Kaya          | 42 Maslak     | System                  | Steps: Information | Telefon Aramasi Planla | Alotech Ulasilamadi | Ücretsiz Ölçüm  |

  # ─────────────────────────────────────────────────────────────────
  # 4b5 - sms onayLI mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b5 @4b
  Scenario Outline: 4b5 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onayLI, atali, telefon gorevi var
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
    And Portal Kulup ikinci kez değiştirilir
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi              | nedenKodu           | expectedKaynak                      |
      | Ela | Kulta | 5981110515 | testlead4b5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Success | Telefon Aramasi Planla | Alotech Ulasilamadi | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 4b6 - sms onaysiz mevcut | atali | randevu/tur gorevi var
  # ### YAVUZA SORULACAK ### TODO
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b6 @4b
  Scenario Outline: 4b6 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, randevu/tur gorevi var
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
    #eklendi /TODO
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu         | expectedKaynak |
      | Ela | Kulta | 5981110516 | testlead4b6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Information | Randevu Planla | Randevu Ayarlandı | Ücretsiz Ölçüm |

  # ─────────────────────────────────────────────────────────────────
  # 4b7 - sms onayLI mevcut | atali | randevu/tur gorevi var - KULUP DEGISMEZ
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b7 @4b
  Scenario Outline: 4b7 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onayLI, atali, randevu/tur gorevi var - kuluba dokunma
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
    And Portal Kulup ikinci kez değiştirilir
    #TODO
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi      | nedenKodu         | expectedKaynak                      |
      | Ela | Kulta | 5981110517 | testlead4b7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Success | Randevu Planla | Randevu Ayarlandı | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 4b8 - sms onaysiz mevcut | atali | ret/satis/uzerine alma gorevi var
  # ### YAVUZA SORULACAK ### TODO
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b8 # kaldırıldı sms onayı olmayan bırıne satıs veremıyoruz
  Scenario Outline: 4b8 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
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

    When Ilk satirda uzerine alinir
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110518 | testlead4b8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ece      | Kaya        | İstanbul | MACFit 42 Maslak | 18.09.2000        | Ece        | Kaya          | 42 Maslak     | System                  | Steps: Information | Tur Olustur | Alotech Ulasilamadi | Ücretsiz Ölçüm  |

  # ─────────────────────────────────────────────────────────────────
  # 4b9 - sms onayLI mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b9 @4b
  Scenario Outline: 4b9 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
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
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags | expectedKaynak | gorevTipi       | nedenKodu           |
      | Ela | Kulta | 5981110519 | testlead4b9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Fişekhane     | System                  |              | AVM Etkinliği  | Satış Görüşmesi | Alotech Ulasilamadi |

  # ─────────────────────────────────────────────────────────────────
  # 4b10 - sms onayLI mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withOTP @4b10 @4b
  Scenario Outline: 4b10 - Gelen SMS onayLI, isim farkli, kulup farkli, mevcut SMS onayLI, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
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
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedAd | expectedSoyad | expectedKulup | expectedSatisTemsilcisi | expectedTags   | expectedKaynak |
      | Ela | Kulta | 5981110520 | testlead4b10@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Katalon  | Automation  | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Katalon    | Automation    | Altunizade    | System                  | Steps: Success | Ücretsiz Ölçüm  |
