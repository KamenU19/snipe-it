FROM snipe/snipe-it:v6.0.11

COPY final.sh .
RUN chmod +x final.sh


ENTRYPOINT ["sh", "/var/www/html/final.sh"]

CMD ["/final.sh", "-D" ,"FOREGROUND"]

EXPOSE 80
EXPOSE 443

#trigger tests2