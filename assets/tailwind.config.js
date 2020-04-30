module.exports = {
    theme: {
        extend: {
            gridTemplateColumns: {
                '14': 'repeat(14, minmax(0, 1fr))',
            },
        },
        variants: {
            gridTemplateColumns: ['responsive', 'hover', 'focus'],
        },
        plugins: [],
    }
}