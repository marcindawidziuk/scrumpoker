import {useCookie} from "#app";

export function isDarkMode(): boolean{
    const darkModeCookie = useCookie<boolean>("dark-mode", {default: () => false})
    return darkModeCookie.value
}

export function setDarkMode(value: boolean){
    const darkModeCookie = useCookie<boolean>("dark-mode", {default: () => false})
    darkModeCookie.value = value
}
