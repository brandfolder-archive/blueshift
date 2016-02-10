CREATE FUNCTION blueshift_id() RETURNS text
    LANGUAGE plpgsql
    AS $$
              DECLARE
                  sec   INT  := CEIL(EXTRACT(SECONDS FROM CURRENT_TIMESTAMP));
                  msec  INT  := (sec * 1000000) - EXTRACT(MICROSECONDS FROM CURRENT_TIMESTAMP);
                  nsec  INT  := (msec * 1000) + random_range(0, 999);
                  epoch INT  := CEIL(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP));
                  rand  INT  := random_range(0,1000000000);
                  sep   TEXT := '-';
                  ret   TEXT := '';
              BEGIN
                  ret := ret || base36_encode(epoch::bigint);
                  ret := ret || sep;
                  ret := ret || base36_encode(nsec::bigint);
                  ret := ret || sep;
                  ret := ret || base36_encode(rand::bigint);
​
                  RETURN ret;
              END;
          $$;
