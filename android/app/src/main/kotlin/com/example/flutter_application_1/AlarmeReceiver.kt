package com.example.tdahelpe

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import android.graphics.BitmapFactory 

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("AlarmReceiver", "🔔 onReceive appelé !")
        Log.d("AlarmReceiver", "Action: ${intent.action}")
        
        val id = intent.getIntExtra("id", 0)
        val title = intent.getStringExtra("title") ?: "Rappel"
        val body = intent.getStringExtra("body") ?: "Il est temps !"
        
        Log.d("AlarmReceiver", "ID: $id, Title: $title, Body: $body")
        
        if (id == 0 && title == "Rappel" && body == "Il est temps !") {
            Log.d("AlarmReceiver", "⚠️ Notification avec valeurs par défaut ignorée")
            return
        }
        
        createNotificationChannel(context)

        // ✅ Créer l'intent qui va ouvrir l'app
        val notificationIntent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            putExtra("notification_id", id) // ← IMPORTANT : Passer l'ID
        }

        val pendingIntent = PendingIntent.getActivity(
            context,
            id,
            notificationIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)  
            .setLargeIcon(BitmapFactory.decodeResource(
                context.resources, 
                R.mipmap.ic_launcher
            )) 
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()

        Log.d("AlarmReceiver", "📢 Affichage notification ID: $id")
        
        NotificationManagerCompat.from(context).notify(id, notification)
    }

    private fun createNotificationChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Alarmes",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications d'alarmes"
            }

            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
            
            Log.d("AlarmReceiver", "✅ Canal de notification créé")
        }
    }

    companion object {
        private const val CHANNEL_ID = "alarm_channel"
    }

   
}