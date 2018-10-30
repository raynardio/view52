ROLE_CATEGORIES = [
    { label: 'intellectual', icon_class: 'ti-book' },
    { label: 'health', icon_class: 'ti-pulse' },
    { label: 'vocational', icon_class: 'ti-clipboard' },
    { label: 'avocational', icon_class: 'ti-basketball' },
    { label: 'spiritual', icon_class: 'ti-thought' },
    { label: 'financial', icon_class: 'ti-money' },
    { label: 'social', icon_class: 'ti-user' }
]

RoleCategory.create! ROLE_CATEGORIES

QUOTES = [
    { text: 'Experience Gratitude' },
    { text: 'Not what\'s wrong, what\'s right?' },
    { text: 'You can always recast the story' },
    { text: 'Abundance over Scarcity' },
    { text: 'Positivity over Negativity' },
    { text: 'Technology allows you to create freedom' },
    { text: 'A major life event happens every 22 years' },
    { text: 'We come together when we’re hatching, matching, and dispatching' },
    { text: 'Singular and dynamic life planning application that guides individuals to experience a life with intention. This is an unofficial early stage wireframe and model.' },

    { quote_type: 'time', text: 'New York is 3 hours ahead of California, but that doesn\'t make California slow. ' },
    { quote_type: 'time', text: 'Someone graduated at the age of 22, but waited 5 years before securing a good job.' },
    { quote_type: 'time', text: 'Someone became a CEO at 25, and died at 50. While another became a CEO at 50 and lived to 90 years.' },
    { quote_type: 'time', text: 'Someone is still single, while someone else got married.' },
    { quote_type: 'time', text: 'Everyone in this world works based on thier time zone.' }
]

Quote.create! QUOTES
