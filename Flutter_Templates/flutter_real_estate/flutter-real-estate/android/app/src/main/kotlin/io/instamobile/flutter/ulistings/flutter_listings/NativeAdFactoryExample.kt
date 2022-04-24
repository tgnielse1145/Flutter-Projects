package io.instamobile.flutter.ulistings.flutter_listings

import android.graphics.Color
import android.view.LayoutInflater
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactoryExample(private val layoutInflater: LayoutInflater) :
    NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any>
    ): NativeAdView {
        val adView =
            layoutInflater.inflate(R.layout.my_native_ad, null) as NativeAdView
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        headlineView.text = nativeAd.headline
        bodyView.text = nativeAd.body
        adView.setBackgroundColor(Color.YELLOW)
        adView.setNativeAd(nativeAd)
        adView.bodyView = bodyView
        adView.headlineView = headlineView
        return adView
    }
}