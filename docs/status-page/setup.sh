#!/bin/bash

echo "🚀 Setting up Kindly Jenkins Status Page"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

print_status "Node.js found: $(node --version)"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install
if [ $? -eq 0 ]; then
    print_status "Dependencies installed successfully"
else
    print_error "Failed to install dependencies"
    exit 1
fi

# Create environment file
echo ""
echo "🔧 Setting up environment..."
if [ ! -f .env ]; then
    cat > .env << 'EOL'
# Jenkins Configuration
JENKINS_USER=your-username
JENKINS_TOKEN=your-api-token

# Optional: GitHub Configuration for Pages
GITHUB_USER=your-github-username
GITHUB_TOKEN=your-github-token
GITHUB_REPO=kindly-jenkins-status
EOL
    print_status "Created .env file with default values"
    print_warning "Please edit .env file with your actual Jenkins credentials"
else
    print_warning ".env file already exists"
fi

# Create public directory
mkdir -p public
print_status "Created public directory"

# Test run (once)
echo ""
echo "🧪 Testing Jenkins connection..."
node update-status.js --once
if [ $? -eq 0 ]; then
    print_status "Test run completed successfully"
    echo ""
    echo "📄 Status page generated at: public/index.html"
    echo "🌐 Open public/index.html in your browser to view the status page"
else
    print_warning "Test run had issues - check your Jenkins credentials in .env"
fi

echo ""
echo "🎯 Setup completed!"
echo ""
echo "Next steps:"
echo "1. Edit .env file with your actual Jenkins credentials"
echo "2. Run 'node update-status.js --once' to test"
echo "3. Use one of these options to keep it running:"
echo ""
echo "   Option A - Manual:"
echo "   node update-status.js"
echo ""
echo "   Option B - PM2 (recommended):"
echo "   npm install -g pm2"
echo "   pm2 start update-status.js --name jenkins-status"
echo "   pm2 startup"
echo "   pm2 save"
echo ""
echo "   Option C - LaunchAgent (macOS):"
echo "   cp kindly.jenkins-status.plist ~/Library/LaunchAgents/"
echo "   launchctl load ~/Library/LaunchAgents/kindly.jenkins-status.plist"
echo ""
echo "🌍 For GitHub Pages hosting:"
echo "1. Create a new repository: kindly-jenkins-status"
echo "2. Initialize git: git init"
echo "3. Add remote: git remote add origin https://github.com/[username]/kindly-jenkins-status.git"
echo "4. Enable GitHub Pages in repository settings"
echo ""
echo "📡 The status page will update every 5 minutes automatically" 