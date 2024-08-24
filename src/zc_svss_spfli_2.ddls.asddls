@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_SVSS_SPFLI_2
  provider contract transactional_query
  as projection on ZR_SVSS_SPFLI_2
{
  key ConnectionId,
  key FlightDate,
  Price,
  @Semantics.currencyCode: true
  CurrencyCode,
  PlaneTypeId,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
