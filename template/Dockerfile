# Writes /build.
FROM docker4gis/angular-builder:v0.0.18 AS builder

# Serves /wwwroot.
FROM docker4gis/angular:v0.0.18

COPY --from=builder /build /wwwroot
