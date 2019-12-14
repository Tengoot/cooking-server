# coding: utf-8
# frozen_string_literal: true

SEED_DATA = {
  recipes: [
    {
      title: 'Makaron z zielonym pesto',
      time_to_prepare: '2 księżyce',
      short_description: 'Świetny sposób na podwieczorek, a podane z gałką ulubionych lodów crumble może być propozycją deseru.',
      description: "1. Przygotowuje pesto.\n2.Makaron gotuję w osolonej wodzie. Odlewa, zachowuje około 125 ml wody.\n3. Makaron wkładam powrotem do garnka dodaje pesto i ewentualnie wodę. Mieszam bardzo dokładnie.\n4. Układam na talerzu i posypuje tartym serem.",
      people_count: 2
    },
    {
      title: 'Ciasteczka kukurydziane',
      time_to_prepare: '2 księżyce',
      short_description: 'Świetny sposób na podwieczorek, a podane z gałką ulubionych lodów crumble może być propozycją deseru.',
      description: "1. Przygotowuje pesto.\n2.Makaron gotuję w osolonej wodzie. Odlewa, zachowuje około 125 ml wody.\n3. Makaron wkładam powrotem do garnka dodaje pesto i ewentualnie wodę. Mieszam bardzo dokładnie.\n4. Układam na talerzu i posypuje tartym serem.",
      people_count: 2
    },
    {
      title: 'Piersi z kurczaka faszerowane serem w grzybowej otulinie',
      time_to_prepare: '2 księżyce',
      short_description: 'Świetny sposób na podwieczorek, a podane z gałką ulubionych lodów crumble może być propozycją deseru.',
      description: "1. Przygotowuje pesto.\n2.Makaron gotuję w osolonej wodzie. Odlewa, zachowuje około 125 ml wody.\n3. Makaron wkładam powrotem do garnka dodaje pesto i ewentualnie wodę. Mieszam bardzo dokładnie.\n4. Układam na talerzu i posypuje tartym serem.",
      people_count: 2
    }
  ],
  ingredients: [
    {
      name: 'Pesto bazyliowe',
      average_price: 12.0,
      kcal: 250,
      description: 'Zielony sos pochodzący z Genui (Liguria) we Włoszech, którego głównym składnikiem jest bazylia. Tradycyjnie wytwarzany w marmurowych moździerzach z oliwy, bazylii, parmezanu lub innego drobno startego twardego sera, orzeszków piniowych i soli.'
    },
    {
      name: 'Makaron pszenny',
      average_price: 6.0,
      kcal: 120,
      description: 'Produkt żywnościowy wytwarzany na bazie mąki, wody i niekiedy jaj (mówimy wtedy o makaronie jajecznym) oraz innych składników, o szerokiej gamie kształtów i zastosowań.'
    },
    {
      name: 'Tarty Parmezan',
      average_price: 6.0,
      kcal: 400,
      description: 'Ser twardy typu podpuszczkowego, wytwarzany z krowiego mleka, leżakujący w solance.'
    },
    {
      name: 'Liście Bazylii',
      average_price: 1.0,
      kcal: 10,
      description: 'Zwyczajowo zwana też bazylią wonną, bazylkiem ogrodowym, bazylijką zwyczajną, balsamem, bazyliszką polską – gatunek rośliny jednorocznej z rodziny jasnotowatych. Pochodzi prawdopodobnie z tropikalnej strefy Afryki, ale obecnie nie rośnie dziko, występuje tylko w uprawie[2]. Nazwa wywodzi się od greckiego βασιλεύς (basileus), czyli król, gdyż wierzono, że tylko król może zerwać tę roślinę. W antycznym Rzymie nazwa tego zioła Basilescus odwoływała się do bazyliszka. Bazylia była wówczas traktowana jako talizman przeciwko tej bestii. Libijczycy spożywali ją dla ochrony przed wężami i skorpionami.'
    }
  ]
}

ActiveRecord::Base.transaction do
  recipes = SEED_DATA[:recipes].map do |recipe_attributes|
    Recipe.find_or_create_by!(**recipe_attributes)
  end

  ingredients = SEED_DATA[:ingredients].map do |ingredient_attributes|
    Ingredient.find_or_create_by!(**ingredient_attributes)
  end

  return if RecipeIngredient.count != 0

  recipes.each do |recipe|
    ingredients.sample(3).each do |ingredient|
      RecipeIngredient.create!(
        amount: rand(10),
        unit: 'gram',
        ingredient: ingredient,
        recipe: recipe
      )
    end
  end
end
