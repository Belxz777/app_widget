package com.flutterjunction.homescreen_widget  // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                val title = widgetData.getString("namefirst", null)
                setTextViewText(R.id.namefirst, title ?: "No title set")

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val counter = widgetData.getInt("_counter", 0)
                val companyone = widgetData.getString("_company1", "")
                val priceone = widgetData.getString("_price1", "")
                val changeone = widgetData.getString("_change1", "")
                val companytwo = widgetData.getString("_company2", "")
                val pricetwo = widgetData.getString("_price2", "")
                val changetwo = widgetData.getString("_change2", "")
                val companythree= widgetData.getString("_company3", "")
                val pricethree = widgetData.getString("_price3", "")
                val changethree = widgetData.getString("_change3", "")
                val companyfour= widgetData.getString("_company4", "")
                val pricefour = widgetData.getString("_price4", "")
                val changefour= widgetData.getString("_change4", "")
                val companyfive= widgetData.getString("_company5", "")
                val pricefive = widgetData.getString("_price5", "")
                val changefive = widgetData.getString("_change5", "")
                val time = widgetData.getString("_time", "")


                var total = counter * 6.3
                var counterText = "Загружено: $total ✅кб" 
    
                    var firstCompany = " $companyone - $priceone ₽ -  📊 $changeone ₽ 🟢"
                var secondCompany = " $companytwo - $pricetwo ₽ 📊 $changetwo ₽ 🟢"
                var thirdCompany = " $companythree - $pricethree ₽ 📊 $changethree ₽ 🟢 "
                var fourthCompany = "$companyfour - $pricefour ₽ 📊 $changefour ₽ 🟢"
                var fifthCompany = " $companyfive - $pricefive ₽ 📊 $changefive ₽ 🟢"
var timing = "🕒 $time"
                if (companyone.isNullOrEmpty() || priceone.isNullOrEmpty()) {
                    var firstCompany = "Проблема с подключением"
                }
                if(companytwo.isNullOrEmpty() || pricetwo.isNullOrEmpty()) {
                    var secondCompany = "Проблема с подключением"
                }
                if(companythree.isNullOrEmpty() || pricethree.isNullOrEmpty()) {
                    var thirdCompany = "Проблема с подключением"
                }
                if(companyfour.isNullOrEmpty() || pricefour.isNullOrEmpty()) {
                    var fourthCompany = "Проблема с подключением"
                }
                if(companyfive.isNullOrEmpty() || pricefive.isNullOrEmpty()) {
                    var fifthCompany = "Проблема с подключением"
                }
                if (counter == 0) {
                    counterText = "You have not pressed the counter button"
                }

                setTextViewText(R.id.tv_counter, counterText)
setTextViewText(R.id.tv_company1, firstCompany)
setTextViewText(R.id.tv_company2, secondCompany)
setTextViewText(R.id.tv_company3,thirdCompany)
setTextViewText(R.id.tv_company4,fourthCompany)
setTextViewText(R.id.tv_company5, fifthCompany)
setTextViewText(R.id.tv_time, timing)
                // Pending intent to update counter on button click
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myAppWidget://updatecounter"))
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}