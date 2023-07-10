#!/bin/sh

SCRIPT_DIR="$(cd "$( dirname "$0" )" >/dev/null && pwd )"
REPO_DIR="$( dirname "$SCRIPT_DIR" )"

TEMPLATE_MODULE=$(egrep "module " "$REPO_DIR/go.mod" | sed "s/module //")
echo "Template module: $TEMPLATE_MODULE"

CURRENT_MODULE=$(git config --get remote.origin.url | sed -E 's#(^.+@)|(\.git$)|(https?://)##g' | sed 's#:#/#')
echo "Current module: $CURRENT_MODULE"

sed -i '' "s|$TEMPLATE_MODULE|$CURRENT_MODULE|g" "$REPO_DIR/README.md"
sed -i '' "s|$TEMPLATE_MODULE|$CURRENT_MODULE|g" "$REPO_DIR/main.go"
sed -i '' "s|$TEMPLATE_MODULE|$CURRENT_MODULE|" "$REPO_DIR/go.mod"

rm $SCRIPT_DIR/init_template.sh
