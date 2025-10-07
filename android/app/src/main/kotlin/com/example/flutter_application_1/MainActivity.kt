package com.example.tdahelpe

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
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
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                                if (!canScheduleExactAlarms()) {
                                    requestExactAlarmPermission()
                                    result.error("NO_PERMISSION", "Permission alarme exacte requise", null)
                                    return@setMethodCallHandler
                                }
                            }
                            
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
                    "checkPermissions" -> {
                        val canSchedule = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                            canScheduleExactAlarms()
                        } else {
                            true
                        }
                        result.success(canSchedule)
                    }
                    "openSettings" -> {
                        openAlarmSettings()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    @RequiresApi(Build.VERSION_CODES.S)
    private fun canScheduleExactAlarms(): Boolean {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        return alarmManager.canScheduleExactAlarms()
    }

    @RequiresApi(Build.VERSION_CODES.S)
    private fun requestExactAlarmPermission() {
        val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM)
        startActivity(intent)
    }

    private fun openAlarmSettings() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
            data = android.net.Uri.parse("package:$packageName")
        }
        startActivity(intent)
    }

    private fun scheduleExactAlarm(id: Int, title: String, body: String, hour: Int, minute: Int) {
        // ✅ Maintenant Log.d() va fonctionner !
        Log.d("MainActivity", "🕐 Programmation alarme ID: $id pour ${hour}h${minute}")
        
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

        val intent = Intent(this, AlarmReceiver::class.java).apply {
            putExtra("id", id)
            putExtra("title", title)
            putExtra("body", body)
        }
        
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            id,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }

        val now = System.currentTimeMillis()
        
        // ✅ SimpleDateFormat va aussi fonctionner !
        Log.d("MainActivity", "⏰ Maintenant: ${SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(now)}")
        Log.d("MainActivity", "⏰ Alarme prévue: ${SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(calendar.timeInMillis)}")

        if (calendar.timeInMillis <= System.currentTimeMillis()) {
            Log.d("MainActivity", "⚠️ Heure passée, ajout d'un jour")
            calendar.add(Calendar.DAY_OF_YEAR, 1)
            Log.d("MainActivity", "⏰ Nouvelle heure: ${SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(calendar.timeInMillis)}")
        }

        val delayMinutes = (calendar.timeInMillis - now) / 1000 / 60
        Log.d("MainActivity", "✅ Programmation de l'alarme dans $delayMinutes minutes")

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            pendingIntent
        )
        
        Log.d("MainActivity", "✅ Alarme programmée avec succès !")
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
        for (id in 1..4) {
            cancelAlarm(id)
        }
    }
}