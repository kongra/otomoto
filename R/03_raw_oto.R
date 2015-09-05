#!/usr/bin/env Rscript
## Created 2015-08-21

library(data.table)

createRawOto <- function(n) {
  data.table(
      Id                            = integer(n),
      ## YOUR CAR
      Brand                         = character(n),
      Model                         = character(n),
      Version                       = character(n),
      ProdYear                      = character(n),
      Mileage                       = character(n),
      FuelType                      = character(n),
      Capacity                      = character(n), # Pojemność skokowa
      Horsepow                      = character(n),
      Gearbox                       = character(n),
      DPF                           = logical(n),   # Filtr cząstek stałych
      Damaged                       = logical(n),   # Uszkodzony

      ## SELLER
      Name                          = character(n),
      Email                         = character(n),
      Location                      = character(n), # Miejscowość+inne dane
      ZipCode                       = character(n), # Kod pocztowy

      ## PRICE
      Value                         = character(n),
      Currency                      = character(n),

      Net                           = logical(n),   # Netto (FALSE = Brutto),
      Negotiable                    = logical(n),
      VATmargin                     = logical(n),   # VAT marża
      VATinvoice                    = logical(n),   # Faktura VAT
      Financing                     = logical(n),   # Możliwość finansowania
      Leasing                       = logical(n),

      ## HISTORY
      CountryOfOrigin               = character(n), # Kraj pochodzenia
      FirstRegMonth                 = character(n), # Miesiąc pierwszej rej.
      FirstRegYear                  = character(n), # Rok pierwszej rej.
      VIN                           = character(n),
      RegInPoland                   = logical(n),   # Czy zarej. w Polsce
      FirstOwner                    = logical(n),   # Czy pierwszy właściciel
      Accidents                     = logical(n),   # FALSE = Bezwypadkowy
      ASO                           = logical(n),   # Czy serwisowany w ASO
      Antique                       = logical(n),   # Czy zarej. jako zabytek
      Tuning                        = logical(n),
      TruckApproved                 = logical(n),   # Czy homologacja ciężarowa

      ## CAR BODY
      BodyType                      = character(n),
      Doors                         = character(n),   # Liczba drzwi
      Seats                         = character(n),   # Liczba miejsc

      Color                         = character(n),
      Metallic                      = logical(n),
      Pearl                         = logical(n),
      Mat                           = logical(n),
      Acrylic                       = logical(n),

      RightHandDrive                = logical(n),  # Kierownica po prawej (Anglik)

      ## ADDITIONAL EQUIPMENT
      ABS                           = logical(n),
      PAS                           = logical(n), # Wspomaganie kierownicy

      Alarm                         = logical(n),
      CentralLocking                = logical(n),
      Immobilizer                   = logical(n),

      HUD                           = logical(n),
      ASR                           = logical(n),
      ParkingAssist                 = logical(n),
      LaneAssist                    = logical(n),
      RainSensor                    = logical(n),
      BlindSpotSensor               = logical(n),
      DuskSensor                    = logical(n),
      FrontParkingSensors           = logical(n),
      RearParkingSensors            = logical(n),
      ReversingCamera               = logical(n),

      AlloyWheels                   = logical(n), # Aluminiowe felgi
      TintedWindows                 = logical(n), # Przyciemniane szyby
      PanoramicRoof                 = logical(n), # Dach panoramiczny
      Sunroof                       = logical(n), # Szyberdach

      ElectrochromicMirrors         = logical(n),
      ElectrochromicRearviewMirror  = logical(n),
      ElectricFrontWindows          = logical(n),
      ElectricRearWindows           = logical(n),
      ElectricallyAdjustableSeats   = logical(n),
      ElectricallyAdjustableMirrors = logical(n),
      ESP                           = logical(n),

      Hook                          = logical(n),
      Isofix                        = logical(n),

      AutomaticClimateControl       = logical(n),
      FourZoneClimateControl        = logical(n),
      TwoZoneClimateControl         = logical(n),
      ManualClimateControl          = logical(n),

      PaddleShifters                = logical(n), # Łopatki zmiany biegów
      MultifunctionSteeringWheel    = logical(n), # Wielofunkcyjna kierownica

      MP3                           = logical(n),
      GPS                           = logical(n),
      DVD                           = logical(n),
      CD                            = logical(n),
      CDChanger                     = logical(n),
      Bluetooth                     = logical(n),
      AUX                           = logical(n),
      SD                            = logical(n),
      USB                           = logical(n),
      OnBoardComputer               = logical(n),
      OriginalAudio                 = logical(n), # Radio fabryczne
      TVTuner                       = logical(n),

      EngineHeater                  = logical(n), # Ogrzewanie postojowe
      HeatedWindscreen              = logical(n), # Podgrzewana przednia szyba
      HeatedMirrors                 = logical(n), # Podgrzewane lusterka boczne
      HeatedFrontSeats              = logical(n),
      HeatedBackSeats               = logical(n),

      KneeAirbag                    = logical(n),
      DriverAirbag                  = logical(n),
      PassengerAirbag               = logical(n),
      FrontAirbags                  = logical(n),
      RearAirbags                   = logical(n),
      SideFrontAirbags              = logical(n),
      SideRearAirbags               = logical(n),
      CurtainAirbags                = logical(n), # Kurtyny powietrzne

      AdjustableSuspension          = logical(n), # Reg. zawieszenie
      TopRails                      = logical(n), # Relingi dachowe
      StartStop                     = logical(n),

      DaytimeRunningLights          = logical(n), # Światła do j. dziennej
      LEDLights                     = logical(n),
      FrontFogLights                = logical(n), # Światła przeciwmgielne
      Xenons                        = logical(n),

      LeatherUpholstery             = logical(n),
      VelvetUpholstery              = logical(n),

      CruiseControl                 = logical(n), # Tempomat
      AdaptiveCruiseControl         = logical(n), # Tempomat aktywny
      SpeedLimiter                  = logical(n))
}
