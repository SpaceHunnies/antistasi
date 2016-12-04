// Returns the larger of [x, y] from markerSize
params ["_marker"];
_markerSize = markerSize _marker;
(_markerSize select 0) max (_markerSize select 1)