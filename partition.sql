-- Partition example.
CREATE TABLE measurement (
    city_id         int not null,
    logdate         date not null,
    peaktemp        int,
    unitsales       int
);


CREATE TABLE measurement (
    city_id         int not null,
    logdate         date not null,
    peaktemp        int,
    unitsales       int
) PARTITION BY RANGE (logdate);

CREATE TABLE measurement_y2007 PARTITION OF measurement
    FOR VALUES FROM ('2007-01-01') TO ('2008-01-01');

CREATE TABLE measurement_y2006m03 PARTITION OF measurement
    FOR VALUES FROM ('2006-03-01') TO ('2006-04-01');


INSERT INTO measurement VALUES (1, '2006-03-04', 1, 1);
INSERT INTO measurement VALUES (2, '2007-03-04', 1, 1);


-- All index will be replicated to all sub tables.
CREATE INDEX ON measurement (logdate);

CREATE INDEX city_id ON measurement (city_id);

-- Offload table
ALTER TABLE measurement DETACH PARTITION measurement_y2006m03 CONCURRENTLY;