# Writes /build.
FROM docker4gis/angular-builder:v0.0.17 AS builder

# Serves /wwwroot.
FROM docker4gis/angular:v0.0.17

COPY --from=builder /build /wwwroot
