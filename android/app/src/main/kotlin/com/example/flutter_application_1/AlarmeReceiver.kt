package com.example.tdahelpe

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log // ← AJOUTE ÇA
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        // ✅ AJOUTE DES LOGS pour comprendre ce qui se passe
        Log.d("AlarmReceiver", "🔔 onReceive appelé !")
        Log.d("AlarmReceiver", "Action: ${intent.action}")
        
        // Récupérer les données depuis l'Intent
        val id = intent.getIntExtra("id", 0)
        val title = intent.getStringExtra("title") ?: "Rappel"
        val body = intent.getStringExtra("body") ?: "Il est temps !"
        
        // ✅ LOG des données reçues
        Log.d("AlarmReceiver", "ID: $id, Title: $title, Body: $body")
        
        createNotificationChannel(context)

        val notification = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()

        // ✅ LOG avant d'afficher la notification
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
            
            // ✅ LOG création du canal
            Log.d("AlarmReceiver", "✅ Canal de notification créé")
        }
    }

    companion object {
        private const val CHANNEL_ID = "alarm_channel"
    }
}