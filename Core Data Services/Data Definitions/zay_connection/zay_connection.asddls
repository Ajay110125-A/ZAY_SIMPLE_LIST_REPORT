@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Data model for simple report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//UI represents objects are shown at app level


@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}// This is helps us to name the table data heading


@Search.searchable: true //This is to make a search bar in the app


define view entity ZAY_CONNECTION
  as select from /dmo/connection
  association [1..*] to ZAJ_FLIGHT_R  as _Flight    on  $projection.CarrierId    = _Flight.CarrierId
                                                    and $projection.ConnectionId = _Flight.ConnectionId
  association [1]    to ZAJ_CARRIER_R as _CarrierId on  $projection.CarrierId = _CarrierId.CarrierId
{ // This creates a block section in app at line item data( Object list )


      @UI.facet: [{ id: 'Connection',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Connection Details'
                  }, // first block of object list
                  { id: 'Flight',
                    purpose: #STANDARD,
                    type: #LINEITEM_REFERENCE,
                    position: 20,
                    label: 'Flight Details',
                    targetElement: '_Flight'
                  } // Second block of object list
                  ]


      @UI.selectionField: [{ position: 10 }] //This helps to put a default selection field in app and also position the fields, custom selection fields can used at app level
      @UI.lineItem: [{ position: 10, label: 'Airline' }] //This helps to postion the field at table data at app and also use lable to change the name at app level
      @UI.identification: [{ position: 10, label: 'Airline' }] //This helps to position the field at Object list page
      @ObjectModel: { //This helps us to expose data of Carrier name in App, for this you need to use @Semantics.text: true at other CDS view field to get the description at app
          text: {
              association: '_CarrierId'
          }
      }
      @Search.defaultSearchElement: true //This one helps us to make the below field searchable at app in search bar
  key carrier_id      as CarrierId,


      @UI.selectionField: [{ position: 20 }] //We cannot change the label at app level but it can done using @EndUserText.label
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,


      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZAY_FLIGHT_VH',
          element: 'AirportId'
      } }] //This helps us to give value help at app level from an CDS View
      @EndUserText.label: 'Departure Airport ID' //This helps us to label the fields at all the UI usage of the fields in app
      airport_from_id as AirportFromId,


      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZAY_FLIGHT_VH',
          element: 'AirportId'
      } }]
      @EndUserText.label: 'Destination Airport ID' //If we need to change a different level then we can use lineitem label option
      airport_to_id   as AirportToId,


      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      @UI.identification: [{ position: 50, label: 'Departure Time' }]
      departure_time  as DepartureTime,


      @UI.lineItem: [{ position: 60, label: 'Arrival Time' }]
      @UI.identification: [{ position: 60, label: 'Arrival Time' }]
      arrival_time    as ArrivalTime,


      @Semantics.quantity.unitOfMeasure: 'DistanceUnit' //This is helps to combine unit of measure with the data at app level
      @UI.identification: [{ position: 70 }]
      distance        as Distance,


      distance_unit   as DistanceUnit,


      // Exposing Association
      @Search.defaultSearchElement: true
      _Flight,


      @Search.defaultSearchElement: true
      _CarrierId
}
