#!/bin/bash

echo "==========================================="
echo "     RHEL Mock Exam Launcher"
echo "==========================================="
echo ""
echo "Which Mock Exam do you want to write?"
echo "1 - Mock 1"
echo "2 - Mock 2"
echo "3 - Mock 3"
echo ""
read -p "Enter your choice (1/2/3): " choice

# GitHub base URL
BASE_URL="https://github.com/Marieswaran2003"
# Decide which mock based on choice
case "$choice" in
    1)
        REPO="labzilla_1"
        ZIP_FILE="mock1.zip"
        ;;
    2)
        REPO="labzilla_2"
        ZIP_FILE="mock2.zip"
        ;;
    3)
        REPO="labzilla_3"
        ZIP_FILE="mock3.zip"
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, or 3."
        exit 1
        ;;
esac

echo ""
echo "Selected Mock: $choice"
echo "Downloading from GitHub repo: $REPO"
echo ""

# Remove old directory if exists
# Remove old directory if exists
rm -rf "$REPO"

# Clone repo
git clone "${BASE_URL}/${REPO}.git"

cd "$REPO" || { echo "Repo download failed!"; exit 1; }

# Unzip mock file
if [ -f "$ZIP_FILE" ]; then
    unzip -o "$ZIP_FILE"
else
    echo "ZIP file $ZIP_FILE not found in repository!"
    exit 1
fi

# Enter mock directory
MOCK_DIR="${ZIP_FILE%.zip}"
cd "$MOCK_DIR" || { echo "Unable to enter mock directory!"; exit 1; }

# Run start script
sudo sh ~/labzilla_${choice}/mock${choice}/practice.sh
sudo cp -r ~/labzilla_${choice}/mock${choice}/* /var/www/html/

                                
