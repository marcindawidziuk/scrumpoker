const { ThemeBuilder, Theme } = require('tailwindcss-theming');

const mainTheme = new Theme()
    .default()
    .assignable()
    .colors({
        'accent':'#667eea',
        'secondary':'#ebf4ff',
        'third':'#ffffff',
        'on-secondary':'#ffffff',
        'brand':'rgb(90, 103, 216)',
        'on-brand':'#ffffff',
        'text-black': '#ffffff'
    });

const lightTheme = new Theme()
    .name('light')
    .assignable()
    .colors( mainTheme.getColors());

const darkTheme = new Theme()
    .dark()
    .colors({
        'accent':'#3b3b78',
        'secondary':'#1f2023',
        'third':'#000000',
        'on-secondary':'#ffffff',
        'brand':'#ff0000',
        'on-brand':'#ffffff',
        'text-black': '#00000f'
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