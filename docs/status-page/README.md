# Kindly Jenkins Status Page

A beautiful, public-facing status page for monitoring the Kindly iOS Jenkins build server.

## 🎯 Overview

This tool creates a public status page for our Jenkins server that runs on Tailscale at `http://100.85.80.14:8080`. It monitors Jenkins health, job statuses, and build information, then generates a beautiful HTML status page that can be hosted publicly via GitHub Pages.

## 🏗️ Architecture

```
Local Mac (Tailscale) → Jenkins → Status Script → GitHub Pages → Public Internet
```

- **Jenkins**: Private on Tailscale network (100.85.80.14:8080)
- **Status Script**: Runs locally, polls Jenkins API every 5 minutes
- **GitHub Pages**: Hosts the generated status page publicly
- **Public Access**: Anyone can view the status page

## 🚀 Quick Setup

1. **Run the setup script:**
   ```bash
   cd Kindly/scripts/jenkins-status-page
   chmod +x setup.sh
   ./setup.sh
   ```

2. **Configure credentials:**
   Edit the `.env` file with your Jenkins API credentials:
   ```env
   JENKINS_USER=your-jenkins-username
   JENKINS_TOKEN=your-jenkins-api-token
   ```

3. **Test the connection:**
   ```bash
   node update-status.js --once
   ```

4. **View the status page:**
   Open `public/index.html` in your browser

## 📋 Prerequisites

- **Node.js** (v14 or higher)
- **Access to Jenkins** via Tailscale network
- **Jenkins API Token** (created in Jenkins → User Settings → API Token)
- **GitHub Account** (optional, for public hosting)

## 🔧 Configuration

### Environment Variables

Create a `.env` file with the following variables:

```env
# Jenkins Configuration (Required)
JENKINS_USER=your-username
JENKINS_TOKEN=your-api-token

# GitHub Configuration (Optional - for Pages hosting)
GITHUB_USER=your-github-username
GITHUB_TOKEN=your-github-token
GITHUB_REPO=kindly-jenkins-status
```

### Getting Jenkins API Token

1. Log into Jenkins at `http://100.85.80.14:8080`
2. Click your username → Configure
3. Add new API Token
4. Copy the generated token to your `.env` file

## 🏃‍♂️ Running the Monitor

### Option 1: Manual (Testing)
```bash
# Run once and exit
node update-status.js --once

# Run continuously (updates every 5 minutes)
node update-status.js
```

### Option 2: PM2 (Recommended for Production)
```bash
# Install PM2 globally
npm install -g pm2

# Start the monitor
pm2 start update-status.js --name jenkins-status

# Set up auto-start on boot
pm2 startup
pm2 save

# Monitor logs
pm2 logs jenkins-status
```

### Option 3: macOS LaunchAgent
Create a plist file and load it as a system service (for automatic startup).

## 🌍 GitHub Pages Hosting

To make your status page publicly accessible:

1. **Create a new GitHub repository:**
   ```bash
   # On GitHub.com, create a new repository named: kindly-jenkins-status
   ```

2. **Set up the repository:**
   ```bash
   cd Kindly/scripts/jenkins-status-page
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/[your-username]/kindly-jenkins-status.git
   git push -u origin main
   ```

3. **Enable GitHub Pages:**
   - Go to repository Settings → Pages
   - Source: Deploy from a branch
   - Branch: main / (root)
   - Click Save

4. **Your status page will be available at:**
   `https://[your-username].github.io/kindly-jenkins-status/`

## 📊 Features

### Status Monitoring
- **Real-time Jenkins Status**: Online/Offline detection
- **Response Time Monitoring**: Track Jenkins API response times
- **Job Status Tracking**: Monitor all Jenkins jobs and their build status
- **Build Information**: Display build numbers, timestamps, and results
- **Version Information**: Show Jenkins version details

### Beautiful UI
- **Modern Design**: Gradient backgrounds with glassmorphism effects
- **Responsive Layout**: Works on desktop, tablet, and mobile
- **Color-coded Status**: Easy-to-understand visual indicators
- **Auto-refresh**: Page updates every 5 minutes automatically
- **Real-time Metrics**: Active jobs, response times, and system info

### Automation
- **Scheduled Updates**: Automatic status checks every 5 minutes
- **Git Integration**: Auto-commits and pushes to GitHub
- **Error Handling**: Graceful handling of Jenkins downtime
- **Logging**: Comprehensive logging for troubleshooting

## 🎨 Customization

### Styling
Edit the CSS in `update-status.js` (line ~90) to customize:
- Colors and gradients
- Layout and spacing
- Typography
- Mobile responsiveness

### Update Frequency
Change the update interval in `update-status.js`:
```javascript
const CONFIG = {
  updateInterval: 5 * 60 * 1000, // 5 minutes in milliseconds
};
```

### Jenkins Jobs
The script automatically discovers and monitors all Jenkins jobs. No configuration needed.

## 🔍 Troubleshooting

### Common Issues

**"Jenkins check failed: timeout"**
- Check if Jenkins is running on the Tailscale network
- Verify your Tailscale connection
- Test Jenkins access: `curl http://100.85.80.14:8080`

**"Authentication failed"**
- Verify your `JENKINS_USER` and `JENKINS_TOKEN` in `.env`
- Ensure the API token has proper permissions
- Test with: `curl -u username:token http://100.85.80.14:8080/api/json`

**"No changes to commit"**
- This is normal if Jenkins status hasn't changed
- The script only commits when the status page content changes

**"No remote configured yet"**
- Set up the GitHub repository and add the remote
- Follow the GitHub Pages setup instructions above

### Debug Mode
Enable detailed logging:
```bash
DEBUG=* node update-status.js --once
```

### Logs
Check PM2 logs:
```bash
pm2 logs jenkins-status
```

## 📁 File Structure

```
Kindly/scripts/jenkins-status-page/
├── package.json          # Node.js dependencies
├── update-status.js      # Main monitoring script
├── setup.sh             # Automated setup script
├── README.md            # This documentation
├── .env                 # Environment variables (created by setup)
├── .gitignore          # Git ignore patterns
├── public/             # Generated status page
│   └── index.html      # The public status page
└── node_modules/       # Dependencies (created by npm install)
```

## 🔒 Security Notes

- Jenkins remains private on the Tailscale network
- Only status information is exposed publicly
- API tokens are used instead of passwords
- Environment variables keep credentials secure
- No sensitive build information is exposed

## 🤝 Contributing

To add features or fix issues:

1. **Test your changes:**
   ```bash
   node update-status.js --once
   ```

2. **Verify the generated page:**
   Open `public/index.html` in your browser

3. **Check for errors:**
   Monitor the console output for any issues

## 📞 Support

For issues or questions:
- Check the troubleshooting section above
- Review the console output for error messages
- Verify your Jenkins API credentials
- Ensure Tailscale connectivity to Jenkins

## 🎯 Roadmap

Future enhancements:
- [ ] Slack/Discord notifications for build failures
- [ ] Historical build data and trends
- [ ] Mobile app for status monitoring
- [ ] Integration with other CI/CD tools
- [ ] Custom alerting rules
- [ ] Performance metrics and analytics 