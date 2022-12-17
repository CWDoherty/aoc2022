FROM perl:latest

ADD . .
RUN cpan -i Math::Geometry::Planar

CMD ["perl", "main.pl"]
