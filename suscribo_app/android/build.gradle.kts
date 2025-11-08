import com.android.build.gradle.BaseExtension
import javax.xml.parsers.DocumentBuilderFactory

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    pluginManager.withPlugin("com.android.library") {
        val androidExtension = extensions.findByType(BaseExtension::class.java)
        if (androidExtension?.namespace.isNullOrEmpty()) {
            val manifestFile = file("src/main/AndroidManifest.xml")
            if (manifestFile.exists()) {
                val builder = DocumentBuilderFactory.newInstance().newDocumentBuilder()
                val manifest = builder.parse(manifestFile)
                val packageName = manifest.documentElement.getAttribute("package")
                if (!packageName.isNullOrEmpty()) {
                    androidExtension?.namespace = packageName
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
