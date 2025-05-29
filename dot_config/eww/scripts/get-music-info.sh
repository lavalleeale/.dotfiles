PREV_TITLE=""
PREV_ARTIST=""

function url_encode() {
    echo "$@" |
        sed \
            -e 's/%/%25/g' \
            -e 's/ /%20/g' \
            -e 's/!/%21/g' \
            -e 's/"/%22/g' \
            -e "s/'/%27/g" \
            -e 's/#/%23/g' \
            -e 's/(/%28/g' \
            -e 's/)/%29/g' \
            -e 's/+/%2b/g' \
            -e 's/,/%2c/g' \
            -e 's/-/%2d/g' \
            -e 's/:/%3a/g' \
            -e 's/;/%3b/g' \
            -e 's/?/%3f/g' \
            -e 's/@/%40/g' \
            -e 's/\$/%24/g' \
            -e 's/\&/%26/g' \
            -e 's/\*/%2a/g' \
            -e 's/\./%2e/g' \
            -e 's/\//%2f/g' \
            -e 's/\[/%5b/g' \
            -e 's/\\/%5c/g' \
            -e 's/\]/%5d/g' \
            -e 's/\^/%5e/g' \
            -e 's/_/%5f/g' \
            -e 's/`/%60/g' \
            -e 's/{/%7b/g' \
            -e 's/|/%7c/g' \
            -e 's/}/%7d/g' \
            -e 's/~/%7e/g'
}

playerctl --follow metadata --format '{{title}}|{{artist}}|{{album}}' | while IFS='|' read -r TITLE ARTIST ALBUM; do
    [ -z "$TITLE" ] && TITLE="Unknown Title"
    [ -z "$ARTIST" ] && ARTIST="Unknown Artist"
    [ -z "$ALBUM" ] && ALBUM="Unknown Album"

    # Only fetch album art if title or artist changed
    if [ "$TITLE" != "$PREV_TITLE" ] || [ "$ARTIST" != "$PREV_ARTIST" ]; then
        if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
            API_DATA=$(curl -s "https://ws.audioscrobbler.com/2.0/?method=track.getInfo&artist=$(sed 's/[^0-9a-zA-Z.-~]/%02X/g' <<<"$ARTIST")&track=$(sed 's/[^0-9a-zA-Z.-~]/%02X/g' <<<"$TITLE")&api_key=923210b7880a7f8938719397f405640a&format=json")
            echo "$API_DATA"
            ART_URL=$(echo "$API_DATA" | jq -r '.track.album.image[-1]."#text"')
            [ -n "$ART_URL" ] && curl -s "$ART_URL" -o /tmp/album_art.png
        fi
        PREV_TITLE="$TITLE"
        PREV_ARTIST="$ARTIST"
    fi
    jq -cn --arg artist "$ARTIST" --arg title "$TITLE" --arg album "$ALBUM" '$ARGS.named'
done
