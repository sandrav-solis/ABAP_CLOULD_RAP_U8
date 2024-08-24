CLASS lhc_zr_svss_spfli_2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrSvssSpfli2
        RESULT result,
      CheckCurr FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrSvssSpfli2~CheckCurr.

ENDCLASS.

CLASS lhc_zr_svss_spfli_2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CheckCurr.

    DATA failed_record   LIKE LINE OF failed-ZrSvssSpfli2.
    DATA reported_record LIKE LINE OF reported-ZrSvssSpfli2.

    READ ENTITIES OF zr_svss_spfli_2 IN LOCAL MODE
         ENTITY ZrSvssSpfli2
         FIELDS ( ConnectionId FlightDate )
           WITH CORRESPONDING #(  keys )
         RESULT DATA(flights).

    LOOP AT flights ASSIGNING FIELD-SYMBOL(<fs_flights>).

      SELECT SINGLE FROM I_Currency
      FIELDS @abap_true
      WHERE Currency = @<fs_flights>-CurrencyCode
      INTO @DATA(vl_exist).

      IF vl_exist = abap_false.
        failed_record-%tky = <fs_flights>-%tky.
        APPEND failed_record TO failed-zrsvssspfli2.

        reported_record-%tky = <fs_flights>-%tky.
        reported_record-%msg =
           new_message(
                id       = ' ZSVSS_MESS_CLASS'
                number   = '004'
                severity = if_abap_behv_message=>severity-error
                v1       = <fs_flights>-CurrencyCode
            ).

        APPEND reported_record TO reported-zrsvssspfli2.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
