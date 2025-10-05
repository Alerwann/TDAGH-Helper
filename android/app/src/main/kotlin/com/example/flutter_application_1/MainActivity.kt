package com.example.flutter_application_1

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar

class MainActivity : FlutterActivity() {
    private val CHANNEL = "alarm_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "scheduleAlarm" -> {
                        val id = call.argument<Int>("id")
                        val title = call.argument<String>("title")
                        val body = call.argument<String>("body")
                        val hour = call.argument<Int>("hour")
                        val minute = call.argument<Int>("minute")

                        if (id != null && title != null && body != null && hour != null && minute != null) {
                            scheduleExactAlarm(id, title, body, hour, minute)
                            result.success("Alarme planifiée pour ${hour}h${minute}")
                        } else {
                            result.error("INVALID_ARGS", "Paramètres manquants", null)
                        }
                    }
                    "cancelAlarm" -> {
                        val id = call.argument<Int>("id")
                        if (id != null) {
                            cancelAlarm(id)
                            result.success("Alarme annulée")
                        } else {
                            result.error("INVALID_ARGS", "ID manquant", null)
                        }
                    }
                    "cancelAllAlarms" -> {
                        cancelAllAlarms()
                        result.success("Toutes les alarmes annulées")
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun scheduleExactAlarm(id: Int, title: String, body: String, hour: Int, minute: Int) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

        val intent = Intent(this, AlarmReceiver::class.java).apply {
            putExtra("id", id)
            putExtra("title", title)
            putExtra("body", body)
        }
        
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id, // Important : utiliser l'ID pour différencier les alarmes
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }

        if (calendar.timeInMillis <= System.currentTimeMillis()) {
            calendar.add(Calendar.DAY_OF_YEAR, 1)
        }

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            pendingIntent
        )
    }

    private fun cancelAlarm(id: Int) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AlarmReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        alarmManager.cancel(pendingIntent)
    }

    private fun cancelAllAlarms() {
        // Annuler les 4 alarmes (IDs 1, 2, 3, 4)
        for (id in 1..4) {
            cancelAlarm(id)
        }
    }
}