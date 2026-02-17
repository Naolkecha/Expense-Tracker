// android/settings.gradle.kts

pluginManagement {
    // Read flutter.sdk from android/local.properties (or FLUTTER_SDK env var)
    val props = java.util.Properties().apply {
        val f = file("local.properties")
        if (f.exists()) f.inputStream().use { load(it) }
    }
    val flutterSdkPath = props.getProperty("flutter.sdk")
        ?: System.getenv("FLUTTER_SDK")
        ?: error("flutter.sdk not set in android/local.properties and FLUTTER_SDK not set")

    // Make Flutter's Gradle plugin available
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_PROJECT)
    repositories {
        google()
        mavenCentral()
    }
}


plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.9.1" apply false
    // Updated Kotlin to 2.1.0 as recommended by Flutter
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
