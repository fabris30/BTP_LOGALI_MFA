@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clientes Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_clnts_lib_mfa
  as select from ztb_clnts_lib_m
{

  key id_libro                     as IdLibro,
      count( distinct id_cliente ) as ventas
}
group by
  id_libro;
