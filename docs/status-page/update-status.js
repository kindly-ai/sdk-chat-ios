#!/usr/bin/env node

const axios = require('axios');
const fs = require('fs');
const path = require('path');
const simpleGit = require('simple-git');

// Configuration
const CONFIG = {
  jenkinsUrl: 'http://100.85.80.14:8080',
  jenkinsUser: process.env.JENKINS_USER || 'your-username',
  jenkinsToken: process.env.JENKINS_TOKEN || 'your-api-token',
  githubRepo: 'kindly-jenkins-status', // Will be created
  outputDir: './public',
  updateInterval: 5 * 60 * 1000, // 5 minutes
};

class JenkinsStatusMonitor {
  constructor() {
    this.git = simpleGit();
    this.ensureOutputDir();
  }

  ensureOutputDir() {
    if (!fs.existsSync(CONFIG.outputDir)) {
      fs.mkdirSync(CONFIG.outputDir, { recursive: true });
    }
  }

  async fetchJenkinsStatus() {
    try {
      console.log('🔍 Checking Jenkins status...');
      
      const [generalInfo, jobs] = await Promise.all([
        this.fetchWithTimeout(`${CONFIG.jenkinsUrl}/api/json`),
        this.fetchWithTimeout(`${CONFIG.jenkinsUrl}/api/json?tree=jobs[name,color,lastBuild[number,timestamp,result,url]]`)
      ]);

      return {
        status: 'online',
        timestamp: new Date().toISOString(),
        version: generalInfo.data.version || 'Unknown',
        jobs: jobs.data.jobs || [],
        responseTime: Date.now() - this.startTime
      };
    } catch (error) {
      console.error('❌ Jenkins check failed:', error.message);
      return {
        status: 'offline',
        timestamp: new Date().toISOString(),
        error: error.message,
        responseTime: null
      };
    }
  }

  async fetchWithTimeout(url, timeout = 10000) {
    this.startTime = Date.now();
    return axios.get(url, {
      auth: {
        username: CONFIG.jenkinsUser,
        password: CONFIG.jenkinsToken
      },
      timeout,
      headers: {
        'Accept': 'application/json'
      }
    });
  }

  generateStatusPage(status) {
    const lastUpdate = new Date(status.timestamp).toLocaleString();
    const isOnline = status.status === 'online';
    
    let jobsHtml = '';
    if (isOnline && status.jobs) {
      jobsHtml = status.jobs.map(job => {
        const statusIcon = this.getJobStatusIcon(job.color);
        const buildNumber = job.lastBuild?.number || 'N/A';
        const buildTime = job.lastBuild?.timestamp ? 
          new Date(job.lastBuild.timestamp).toLocaleString() : 'Never';
        
        return `
          <div class="job-card">
            <div class="job-header">
              <h3>${job.name}</h3>
              <span class="status-badge ${job.color}">${statusIcon}</span>
            </div>
            <div class="job-details">
              <p>Build #${buildNumber}</p>
              <p class="build-time">${buildTime}</p>
            </div>
          </div>
        `;
      }).join('');
    }

    return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kindly iOS Jenkins Status</title>
    <meta http-equiv="refresh" content="300"> <!-- Auto refresh every 5 minutes -->
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            text-align: center;
        }
        
        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 25px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 18px;
            margin: 20px 0;
        }
        
        .online {
            background: #4CAF50;
            color: white;
        }
        
        .offline {
            background: #f44336;
            color: white;
        }
        
        .metrics {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .metric-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }
        
        .metric-value {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .metric-label {
            color: #666;
            font-size: 14px;
        }
        
        .jobs-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-top: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        
        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .job-card {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 20px;
            border-radius: 8px;
            transition: transform 0.2s;
        }
        
        .job-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }
        
        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .blue { background: #4CAF50; color: white; }
        .red { background: #f44336; color: white; }
        .yellow { background: #FF9800; color: white; }
        .grey { background: #9E9E9E; color: white; }
        .aborted { background: #607D8B; color: white; }
        
        .build-time {
            color: #666;
            font-size: 12px;
        }
        
        .footer {
            text-align: center;
            margin-top: 40px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .error-message {
            background: #ffebee;
            border: 1px solid #f44336;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            color: #c62828;
        }
        
        @media (max-width: 768px) {
            .container { padding: 10px; }
            .header { padding: 20px; }
            .jobs-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛠️ Kindly iOS Jenkins</h1>
            <div class="status-indicator ${isOnline ? 'online' : 'offline'}">
                ${isOnline ? '✅ Online' : '❌ Offline'}
            </div>
            <p>Build Infrastructure Status</p>
            
            ${isOnline ? `
                <div class="metrics">
                    <div class="metric-card">
                        <div class="metric-value">${status.jobs ? status.jobs.length : 0}</div>
                        <div class="metric-label">Active Jobs</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value">${status.responseTime}ms</div>
                        <div class="metric-label">Response Time</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value">${status.version}</div>
                        <div class="metric-label">Jenkins Version</div>
                    </div>
                </div>
            ` : `
                <div class="error-message">
                    <strong>Connection Error:</strong> ${status.error || 'Unable to reach Jenkins server'}
                </div>
            `}
        </div>
        
        ${isOnline && jobsHtml ? `
            <div class="jobs-section">
                <h2>📊 Build Jobs</h2>
                <div class="jobs-grid">
                    ${jobsHtml}
                </div>
            </div>
        ` : ''}
        
        <div class="footer">
            <p>Last updated: ${lastUpdate}</p>
            <p>Page refreshes automatically every 5 minutes</p>
        </div>
    </div>
</body>
</html>
    `.trim();
  }

  getJobStatusIcon(color) {
    switch (color) {
      case 'blue': return '✅ Success';
      case 'red': return '❌ Failed';
      case 'yellow': return '⚠️ Unstable';
      case 'aborted': return '⏹️ Aborted';
      case 'grey': return '⚫ Not Built';
      default: return '❓ Unknown';
    }
  }

  async saveStatusPage(html) {
    const filePath = path.join(CONFIG.outputDir, 'index.html');
    fs.writeFileSync(filePath, html);
    console.log(`✅ Status page saved to ${filePath}`);
  }

  async updateGitRepo() {
    try {
      // Check if git repo exists
      const isRepo = fs.existsSync('.git');
      
      if (!isRepo) {
        console.log('🔧 Initializing git repository...');
        await this.git.init();
        await this.git.addConfig('user.name', 'Jenkins Status Bot');
        await this.git.addConfig('user.email', 'jenkins-status@kindly.ai');
      }

      // Add and commit changes
      await this.git.add(CONFIG.outputDir);
      
      const status = await this.git.status();
      if (status.files.length > 0) {
        await this.git.commit(`Update Jenkins status - ${new Date().toISOString()}`);
        console.log('✅ Changes committed to git');
        
        // Push if remote exists
        try {
          await this.git.push('origin', 'main');
          console.log('✅ Changes pushed to GitHub');
        } catch (error) {
          console.log('ℹ️  No remote configured yet. Status updated locally.');
        }
      } else {
        console.log('ℹ️  No changes to commit');
      }
    } catch (error) {
      console.error('⚠️  Git operation failed:', error.message);
    }
  }

  async run() {
    console.log('🚀 Starting Jenkins status monitor...');
    
    const status = await this.fetchJenkinsStatus();
    const html = this.generateStatusPage(status);
    await this.saveStatusPage(html);
    await this.updateGitRepo();
    
    console.log(`📊 Status: ${status.status}`);
    console.log(`🔄 Next update in ${CONFIG.updateInterval / 1000 / 60} minutes`);
  }

  startMonitoring() {
    // Run immediately
    this.run();
    
    // Then run every interval
    setInterval(() => {
      this.run();
    }, CONFIG.updateInterval);
    
    console.log('🎯 Jenkins status monitor is running...');
    console.log('🌐 Open public/index.html to view the status page');
    console.log('📡 Status updates every 5 minutes');
  }
}

// Run the monitor
if (require.main === module) {
  const monitor = new JenkinsStatusMonitor();
  
  if (process.argv.includes('--once')) {
    // Run once and exit
    monitor.run();
  } else {
    // Run continuously
    monitor.startMonitoring();
  }
}

module.exports = JenkinsStatusMonitor; 