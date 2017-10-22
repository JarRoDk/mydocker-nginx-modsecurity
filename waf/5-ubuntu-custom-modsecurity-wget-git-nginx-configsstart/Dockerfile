FROM ubuntu-custom-modsecurity-wget-git-nginx
#configure env
RUN mkdir -p /opt/modsecurity/var/audit/

#install signature
RUN cp -R /usr/src/owasp-modsecurity-crs/rules/ /etc/nginx
RUN mv /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
RUN mv /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf
#
#RUN apt-get purge -y build-essential 
RUN rm /nginx-1.12.0.tar.gz
#
ADD nginx.conf /etc/nginx/nginx.conf
ADD modsec_includes.conf /etc/nginx//modsec_includes.conf
ADD modsecurity.conf /etc/nginx/modsecurity.conf
ADD crs-setup.conf /etc/nginx/rules/crs-setup.conf
#
CMD nginx -g 'daemon off;'

EXPOSE 808
