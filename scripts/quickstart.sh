#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting EAM Setup...${NC}"

# Check prerequisites
command -v flutter >/dev/null 2>&1 || { echo "Flutter is required but not installed. Aborting." >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "Python 3 is required but not installed. Aborting." >&2; exit 1; }
command -v pip3 >/dev/null 2>&1 || { echo "pip3 is required but not installed. Aborting." >&2; exit 1; }

# Function to start a component
start_component() {
    local component=$1
    local dir=$2
    local cmd=$3
    
    echo -e "${GREEN}Starting $component...${NC}"
    cd "$dir" || exit
    eval "$cmd" &
    cd - > /dev/null
}

# Create Python virtual environments and install dependencies
echo -e "${BLUE}Setting up Python environments...${NC}"

# Backend setup
cd backend || exit
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
deactivate
cd ..

# Security model setup
cd security || exit
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
deactivate
cd ..

# Start all components
start_component "AI Backend" "backend" "source venv/bin/activate && python main.py"
start_component "Security Check Model" "security" "source venv/bin/activate && python security_service.py"

# Start Charlotte (Flutter frontend)
echo -e "${GREEN}Starting Charlotte (Frontend)...${NC}"
cd charlotte || exit
flutter pub get
flutter run -d chrome --web-port 3000

echo -e "${BLUE}All components started successfully!${NC}"
echo -e "${BLUE}Access the application at: http://localhost:3000${NC}"
