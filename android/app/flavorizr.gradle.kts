import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.cleanser.dev"
            resValue(type = "string", name = "app_name", value = "Cleanser Dev")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "com.cleanser.uat"
            resValue(type = "string", name = "app_name", value = "Cleanser UAT")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.cleanser"
            resValue(type = "string", name = "app_name", value = "Cleanser")
        }
    }
}