
FROM snipe/snipe-it:v6.0.11

COPY final.sh .
RUN sudo chmod +x ./app/dockerfiles/final.sh


ENTRYPOINT ["sh", "/var/www/html/final.sh"]

CMD ["/final.sh", "-D" ,"FOREGROUND"]

EXPOSE 80
EXPOSE 443
