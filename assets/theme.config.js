const { ThemeBuilder, Theme } = require('tailwindcss-theming');

const mainTheme = new Theme()
    .default()
    .assignable()
    .colors({
        'accent':'#667eea',
        'secondary':'#ebf4ff',
        'third':'#ffffff',
        'on-accent':'#fff',
        'on-secondary':'rgb(74, 85, 104)',
        'brand':'rgb(90, 103, 216)',
         'disabled':'#f7fafc',
         'disabled-secondary': '#e2e8f0',
        'ideal-background': '#fff',
        'on-brand':'#ffffff',
        'black': '#000',
        'card': '#fafafa',
        'on-card': '#111',
        'background': '#fff',
        'foreground': '#111'
    });

const lightTheme = new Theme()
    .name('light')
    .assignable()
    .colors( mainTheme.getColors());

const darkTheme = new Theme()
    .dark()
    .colors({
        'accent':'#667eea',
        'secondary':'#24262b',
        'third':'#000000',
        'ideal-background': '#000',
         'disabled':'#f7fafc',
        'on-secondary':'#ffffff',
        'brand':'rgb(127, 156, 245)',
        'on-brand':'#ffffff',
        'black': '#000',
        'background': '#111',
        'foreground': '#fff'
    })
    .assignable();

// const lightTheme = new Theme()
//     .light()
//     .colors({
//         'accent':'#667eea',
//         'brand':'rgb(90, 103, 216)',
//         'on-brand':'#ffffff',
//         'text-black': '#ffffff'
//     })
// ;
//

module.exports = new ThemeBuilder()
    .asDataThemeAttribute()
    .default(mainTheme)
    .light(lightTheme, true, true)
    .dark(darkTheme);