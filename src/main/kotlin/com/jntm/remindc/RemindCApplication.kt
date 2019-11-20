package com.jntm.remindc

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.ComponentScan
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class RemindCApplication

fun main(args: Array<String>) {
    var target = -5
    val num = 3

    target =- num // Noncompliant; target = -3. Is that really what's meant?
    target =+ num // Noncompliant; target = 3
    runApplication<RemindCApplication>(*args)
}
