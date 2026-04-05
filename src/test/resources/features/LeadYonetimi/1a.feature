@LeadPortalFlow1a
Feature: 1a - Gelen SMS onaysiz lead, isim ayni, kulup farkli
  #olympus.su dan gıdılıcek
  # Kural: Gelen lead SMS onaysiz | Mevcut isim ayni | Kulup farkli
  # Aksiyonlar: source guncelle, kulup guncelle, satis temsilcisi=system, gorevleri kapat, status ret ise aktife cek, history at
  # NOT: Her Scenario Outline bagimsiz calisir. Biri patlarsa diger devam eder.
  #      Jenkins'te maven-surefire-plugin failFast=false ile tum senaryolar kosar.

  # ─────────────────────────────────────────────────────────────────
  # 1a1 - sms onaysiz mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a1 @1a
  Scenario Outline: 1a1 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atanmamis, gorev var/yok

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
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard kontrole hazirlanir
    When Aday uye listesine gidilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu           | vucutUrl            | vucutKulup            | expectedKaynak                       |
      | Ela | Kulta | 5981110501 | testlead1a1@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | 42 Maslak     | System                  | Steps: PhoneNumber | Randevu Planla | Alotech Ulasilamadi | vucut-analizi-formu | MACFit Flatofis Haliç | Web Form - Günlük Üyelik Kampanyası  |

  # ─────────────────────────────────────────────────────────────────
  # 1a2 - sms onayLI mevcut | atamasiz | gorev var/yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a2 @1a  # TODO satıs temsılcısıne atalı olmayacak joın us gıdılıcek vucut formuna gıdıcek
  Scenario Outline: 1a2 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atanmamis, gorev var/yok
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
    And iki saniye bekler
    Then Portal OTP dogrulamasi atlanir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye dashboarda gidilir
    When ortak random gsm no ile telefon aramasi yapilir
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5998626473 | testlead1a2@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | Fişekhane     | System                  |              | Tur Olustur | Alotech Ulasilamadi | Website        |

  # ─────────────────────────────────────────────────────────────────
  # 1a3 - sms onaysiz mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a3 @1a
  Scenario Outline: 1a3 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atali, gorev yok
    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>" dogumtarihi "<dogumTarihi>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    Then Portal devam butonuna basilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<portalDogumTarihi>"
    And Portal Kulup ikinci kez değiştirilir
    #42MASLAK SECILIR
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi       | nedenKodu           | expectedKaynak  |
      | Ela | Kulta | 5981110503 | testlead1a3@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | Kulta       | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Altunizada    | System                  | steps: Information | Satış Görüşmesi | Alotech Ulasilamadi | Vücut Analizi   |

  # ─────────────────────────────────────────────────────────────────
  # 1a4 - sms onaysiz mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  # ####################  BU SENARYO KALDIRILDI. ####################
  Scenario Outline: 1a4 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atali, telefon gorevi var
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
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110504 | testlead1a4@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | System                  | Steps: Information | Telefon Aramasi Planla | Alotech Ulasilamadi | Website        |

  # ─────────────────────────────────────────────────────────────────
  # 1a5 - sms onayLI mevcut | atali | telefon gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a5 @1a
  Scenario Outline: 1a5 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atali, telefon gorevi var
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
    #Altunizade
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedKulup  | expectedSatisTemsilcisi | expectedTags       | gorevTipi              | nedenKodu           | expectedKaynak                      |
      | Ela | Kulta | 5981110505 | testlead1a5@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | Kulta       | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Flatofis Haliç | System                  | Steps: PhoneNumber | Telefon Aramasi Planla | Alotech Ulasilamadi | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 1a6 - sms onaysiz mevcut | atali | randevu/tur/ Satış Görüşmesi  gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a6   ### 1a6 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  Scenario Outline: 1a6 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atali, randevu/tur gorevi var
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
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur
  #görevleri kapat ıcın TODO
    # işlemtarihçesi için TODO


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi       | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110506 | testlead1a6@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | System                  | Ücretsiz Ölçüm | Satış Görüşmesi | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 1a7 - sms onayLI mevcut | atali | randevu/tur/ Satış Görüşmesi  gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a7 @1a
  Scenario Outline: 1a7 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atali, randevu/tur gorevi var
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
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur



    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup           | portalDogumTarihi | expectedKulup  | expectedSatisTemsilcisi | expectedTags       | gorevTipi      | nedenKodu         | expectedKaynak                      |
      | Ela | Kulta | 5981110507 | testlead1a7@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | Kulta       | İstanbul | MACFit Flatofis Haliç | 18.09.2000        | Flatofis Haliç | System                  | Steps: PhoneNumber | Randevu Planla | Randevu Ayarlandı | Web Form - Günlük Üyelik Kampanyası |

  # ─────────────────────────────────────────────────────────────────
  # 1a8 - sms onaysiz mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  ### 1a8 Bu senaryo ıcın  Satış Görüşmesi  olması ıcın is sms approveun 1 olması lazım####
  @withoutOTP @1a8
  Scenario Outline: 1a8 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onaysiz, atali, ret/satis/uzerine alma gorevi var
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
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur


    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl           | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags   | gorevTipi   | nedenKodu           | expectedKaynak |
      | Ela | Kulta | 5981110508 | testlead1a8@hotmail.com | Kulube gelen | 01.01.1990  | vucut-analizi-formu | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | System                  | Ücretsiz Ölçüm | Tur Olustur | Alotech Ulasilamadi | Vücut Analizi  |

  # ─────────────────────────────────────────────────────────────────
  # 1a9 - sms onayLI mevcut | atali | ret/satis/uzerine alma gorevi var
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a9 @1a
  Scenario Outline: 1a9 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atali, ret/satis/uzerine alma gorevi var
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
    And avm disi formunda kulup "Flatofis Haliç" secilir
    And avm disi formuna ortak random gsm no girilir
    And avm disi formunda izinler kabul edilir
    And avm disi formunda Devam Et butonuna basilir
    And OTP dogrulamasi kapatilir

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye dashboarda gidilir
    When ortak random gsm no ile telefon aramasi yapilir
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur



    Examples:
      | ad  | soyad | gsmNo      | email                   | kaynak       | dogumTarihi | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | portalDogumTarihi | expectedKulup  | expectedSatisTemsilcisi | expectedTags | gorevTipi       | nedenKodu           | formKulup | expectedKaynak |
      | Ela | Kulta | 5981110509 | testlead1a9@hotmail.com | Kulube gelen | 01.01.1990  | dijital-uyelik-formu | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | 18.09.2000        | Flatofis Haliç | System                  |              | Satış Görüşmesi | Alotech Ulasilamadi | 42 Maslak | AVM Etkinliği  |

  # ─────────────────────────────────────────────────────────────────
  # 1a10 - sms onayLI mevcut | atali | gorev yok
  # ─────────────────────────────────────────────────────────────────
  @withoutOTP @1a10 @1a
  Scenario Outline: 1a10 - Gelen SMS onaysiz, isim ayni, kulup farkli, mevcut SMS onayLI, atali, gorev yok
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
    And iki saniye bekler
    Then Ilk satirda ad "<portalAd>" gorunur
    And Ilk satirda soyad "<portalSoyad>" gorunur
    And Ilk satirda kulup "<expectedKulup>" gorunur
    And Ilk satirda satis temsilcisi "<expectedSatisTemsilcisi>" gorunur
    And Ilk satirda tags "<expectedTags>" gorunur
    And Ilk satirda kaynak "<expectedKaynak>" gorunur

    Examples:
      | ad  | soyad | gsmNo      | email                    | kaynak       | dogumTarihi | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | portalDogumTarihi | personelNo | expectedKulup | expectedSatisTemsilcisi | expectedTags | expectedKaynak |
      | Ela | Kulta | 5981110510 | testlead1a10@hotmail.com | Kulube gelen | 01.01.1990  | join-us   | Ela      | Kulta       | İstanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000        | 5941412    | 42 Maslak     | System                  | Steps: Clubs | Website        |
