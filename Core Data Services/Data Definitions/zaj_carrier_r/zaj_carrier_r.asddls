@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZAJ_CARRIER_R
  as select from /dmo/carrier
{
  key carrier_id    as CarrierId,
      @Semantics.text: true //This helps to show the Carrier ID description at app level
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8 //This helps us to search or filter the data by giving some letter of the Airline name 0.8 is default
      name          as Name,
      currency_code as CurrencyCode
}
