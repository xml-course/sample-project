import org.springframework.boot.gradle.plugin.SpringBootPlugin

plugins {
    java

    id("org.springframework.boot") version "3.3.5"
}

repositories {
    mavenCentral()
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

dependencies {
    implementation(platform(SpringBootPlugin.BOM_COORDINATES))

    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.apache.xmlgraphics:fop:2.10")

    runtimeOnly("org.webjars:webjars-locator-core:0.59")
    runtimeOnly("org.webjars:bootstrap:5.3.3")
}
