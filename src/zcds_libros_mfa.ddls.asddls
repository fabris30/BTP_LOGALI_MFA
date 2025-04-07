@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Metadata.allowExtensions: true

define view entity zcds_libros_mfa
  as select from    ztb_libros_mfa     as Libros
    inner join      zcds_catego_mfa    as Categorias on Libros.bi_categ = Categorias.Categoria
    left outer join zcds_clnts_lib_mfa as Ventas     on Libros.id_libro = Ventas.IdLibro
  association [0..*] to zcds_clientes_mfa as _Clientes on $projection.IdLibro = _Clientes.IdLibros

{
  key Libros.id_libro        as IdLibro,
      Libros.titulo          as Titulo,
      Libros.bi_categ        as Categoria,

      Libros.autor           as Autor,
      Libros.editorial       as Editorial,
      Libros.idioma          as Idioma,
      Libros.paginas         as Paginas,
      @Semantics.amount.currencyCode: 'Moneda'
      Libros.precio          as Precio,
      Libros.moneda          as Moneda,

      case
      when Ventas.ventas < 1 then 0
       when Ventas.ventas = 1 then 1
        when Ventas.ventas = 2 then 2
         when Ventas.ventas > 2 then 3
      else 0
      end                    as Ventas,
      Categorias.Descripcion as Descripcion,
      Libros.formato         as Formato,
      Libros.url             as Imagen,
      _Clientes
}
