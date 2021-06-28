
new File(".").eachFile { f ->
    if (f.name =~ /.*.jpg/) {
        println "    - assets/images/cards/${f.name}"
    }
}
