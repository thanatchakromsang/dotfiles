import type { Plugin } from "@opencode-ai/plugin"

export const TelegramNotification: Plugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        // Read Telegram credentials from environment or file paths
        // Configure via sops-nix: TELEGRAM_BOT_TOKEN_FILE or TELEGRAM_BOT_TOKEN
        const botToken = process.env.TELEGRAM_BOT_TOKEN || 
          await Bun.file(process.env.TELEGRAM_BOT_TOKEN_FILE || "").text().catch(() => "")
        
        const chatId = process.env.TELEGRAM_CHAT_ID || 
          await Bun.file(process.env.TELEGRAM_CHAT_ID_FILE || "").text().catch(() => "")
        
        if (botToken?.trim() && chatId?.trim()) {
          const timestamp = new Date().toLocaleString('en-US', {
            timeZone: 'Asia/Bangkok',
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false
          })
          
          const message = `🤖 <b>OpenCode Session Complete</b>

📅 Time: ${timestamp}
📊 Status: Idle

Task completed successfully.`
          
          try {
            await $`curl -s -X POST "https://api.telegram.org/bot${botToken.trim()}/sendMessage" \
              -d "chat_id=${chatId.trim()}" \
              -d "text=${message}" \
              -d "parse_mode=HTML"`.quiet()
          } catch (error) {
            // Silently fail - don't interrupt user workflow
            console.error('Telegram notification failed:', error)
          }
        }
      }
    },
  }
}
