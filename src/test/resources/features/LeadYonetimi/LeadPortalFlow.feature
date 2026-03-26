
@LeadPortalFlow
Feature: Lead Portal Akisi - Olympus Aday Uye + Portal 2. Gidis

  @withoutOTP @1A1
  Scenario Outline: 1A1 - Aday uye olustur dijital uyelik 2. gidis OTPsiz

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>"
    And OTP dogrulamasi atlanir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<dogumTarihi>"
    And Portal formu gonderilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda kaynak "<expectedKaynak>" gorunur
    When Ilk satirda uzerine alinir
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir
    Then Telefon ile arama yapilir "<gsmNo>"
    And Ilk satirda isim "<portalAd>" gorunur

    Examples:
      | ad    | soyad | gsmNo      | email                  | kaynak  | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | dogumTarihi | expectedKaynak       | gorevTipi      | nedenKodu           |
      | Boran | Boran | 5981110515 | testfirat1@hotmail.com | Insider | dijital-uyelik-formu | ahmet    | ahmet       | Istanbul | MACFit 42 Maslak | 18.09.2000  | Website Kampanyalari | Randevu Planla | Alotech Ulasilamadi |

  @withoutOTP @1A2
  Scenario Outline: 1A2 - Aday uye olustur joinus 2. gidis OTPsiz

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>"
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
    And JoinUs formu doldurulur ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<dogumTarihi>" personelno "<personelNo>"
    And JoinUs onay butonuna basilir
    Then Portal OTP dogrulamasi atlanir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda kaynak "<expectedKaynak>" gorunur
    When Ilk satirda uzerine alinir
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir
    Then Telefon ile arama yapilir "<gsmNo>"
    And Ilk satirda isim "<portalAd>" gorunur

    Examples:
      | ad    | soyad | gsmNo      | email                  | kaynak  | portalUrl | portalAd | portalSoyad | sehir    | portalKulup      | ulke        | dogumTarihi | personelNo | expectedKaynak | gorevTipi   | nedenKodu           |
      | Boran | Boran | 5981110516 | testfirat1@hotmail.com | Insider | join-us   | ahmet    | ahmet       | Istanbul | MACFit 42 Maslak | Afghanistan | 18.09.2000  | 5941412    | Join Us        | Tur Olustur | Alotech Ulasilamadi |

  @withOTP @1B1
  Scenario Outline: 1B1 - Aday uye olustur OTPli dijital uyelik 2. gidis OTPli

    Given Olympus dashboard acilir ve giris yapilir
    When Aday uye sayfasina gidilir
    And Aday uye ekle formuna bilgiler girilir ad "<ad>" soyad "<soyad>" gsmNo "<gsmNo>" email "<email>" kaynak "<kaynak>"
    And SMS kodu DBden cekilip OTP girilir "<gsmNo>"
    And OTP confirm butonuna basilir
    Then Aday uye basariyla olusturulur

    When "<portalUrl>" portali acilir
    And Portala telefon numarasi girilir "<gsmNo>"
    And Portal sehir "<sehir>" secilir
    And Portal kulup "<portalKulup>" secilir
    And Portal form bilgileri girilir ad "<portalAd>" soyad "<portalSoyad>" email "<email>" dogumtarihi "<dogumTarihi>"
    And Portal formu gonderilir
    And Portal SMS kodu DBden cekilip girilir "<gsmNo>"
    And Portal OTP confirm butonuna basilir

    Given Olympus sekmesine gecilir
    When Telefon ile arama yapilir "<gsmNo>"
    Then Ilk satirda kaynak "<expectedKaynak>" gorunur
    When Ilk satirda uzerine alinir
    And "<gorevTipi>" gorevi atanir
    And Gorev "<nedenKodu>" neden koduyla kaydedilir
    Then Telefon ile arama yapilir "<gsmNo>"
    And Ilk satirda isim "<portalAd>" gorunur

    Examples:
      | ad    | soyad | gsmNo      | email                  | kaynak  | portalUrl            | portalAd | portalSoyad | sehir    | portalKulup      | dogumTarihi | expectedKaynak       | gorevTipi      | nedenKodu           |
      | Boran | Boran | 5981110517 | testfirat1@hotmail.com | Insider | dijital-uyelik-formu | ahmet    | ahmet       | Istanbul | MACFit 42 Maslak | 18.09.2000  | Website Kampanyalari | Randevu Planla | Alotech Ulasilamadi |
