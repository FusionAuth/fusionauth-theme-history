
. .env

mkdir -p $TMP_DIR

curl -H 'Authorization: '$API_KEY  $FUSIONAUTH_URL/api/theme/$THEME_ID > $TMP_DIR/themeout.json
cat $TMP_DIR/themeout.json |jq '.theme.templates' > $TMP_DIR/templates.json

# splits template files
node splitfiles.js templates.json .ftl

cat $TMP_DIR/themeout.json |jq '.theme.defaultMessages'  |sed 's/^"//' |sed 's/"$//' |node convert-newlines.js > $TMP_DIR/defaultMessages.txt

cat $TMP_DIR/themeout.json |jq '.theme.localizedMessages' > $TMP_DIR/localizedMessages.json
node splitfiles.js localizedMessages.json .txt

# empty string if null https://stackoverflow.com/questions/53135035/jq-returning-null-as-string-if-the-json-is-empty
cat $TMP_DIR/themeout.json |jq '.theme.stylesheet // empty'  |sed 's/^"//' |sed 's/"$//' |node convert-newlines.js > $TMP_DIR/styles.css

#curl -H 'Authorization: '$API_KEY  $FUSIONAUTH_URL/api/theme/$THEME_ID|jq '.theme.localizedMessages' > $TMP_DIR/localizedMessages.properties


#rm $TMP_DIR/templates.json $TMP_DIR/themeout.json
