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
                val nameFirst = widgetData.getString("namefirst", "")
                val priceFirst = widgetData.getString("pricefirst", "")
                val nameTwo = widgetData.getString("secondname", "")
                val priceTwo = widgetData.getString("pricesecond", "")
                val nameThree= widgetData.getString("thirdname", "")
                val priceThree = widgetData.getString("pricethird", "")
             var counterText = "Нажали на кнопку : $counter"
               
         
         setTextViewText(R.id._counter, counterText)
setTextViewText(R.id.namefirst, nameFirst)
setTextViewText(R.id.pricefirst, priceFirst)
setTextViewText(R.id.secondname, nameTwo)
setTextViewText(R.id.pricesecond, priceTwo)
setTextViewText(R.id.thirdname, nameThree)
setTextViewText(R.id.pricethird, priceThree)
                // Pending intent to update counter on button click
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myAppWidget://updatecounter"))
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}