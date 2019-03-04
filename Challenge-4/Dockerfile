FROM alpine
COPY notifications.sh /notifications.sh
RUN apk add postfix && apk add mailx && postfix start
RUN chmod +x /notifications.sh
ENTRYPOINT ["sh", "/notifications.sh"]
