@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Information'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZAJ_FLIGHT_R
  as select from /dmo/flight
  association [1] to ZAJ_CARRIER_R as _CarrierId on $projection.CarrierId = _CarrierId.CarrierId
{
  @UI.identification: [{ position: 10 }]
  @ObjectModel.text.association: '_CarrierId'
  key carrier_id     as CarrierId,
  @UI.identification: [{ position: 20 }]
  key connection_id  as ConnectionId,
  @UI.identification: [{ position: 30 }]
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode' //This mandatory to add the Unit of measure to numeric fields like amount, distance etc
      @UI.identification: [{ position: 40 }]
      price          as Price,
      @UI.identification: [{ position: 50 }]
      currency_code  as CurrencyCode,
      @UI.identification: [{ position: 60 }]
      @Search.defaultSearchElement: true
      plane_type_id  as PlaneTypeId,
      @UI.identification: [{ position: 70 }]
      seats_max      as SeatsMax,
      @UI.identification: [{ position: 80 }]
      seats_occupied as SeatsOccupied,
      
      // Exposing Association
      _CarrierId
}
