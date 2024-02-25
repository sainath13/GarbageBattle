import 'package:flutter/material.dart';
import 'package:garbage_sorting/garbage_type.dart';
import 'package:garbage_sorting/main.dart';

List<Item> _itemsBackup = [
  const Item(
    name: 'Aluminium can',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: AssetImage('assets/alum_can.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oops! Looks like this can needs a different destination. Think about where you'd recycle it.",
  ),
  const Item(
    name: 'Band-Aids',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: AssetImage('assets/band_aids.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Uh-oh! Seems like this item is more suited for a specific bin. Consider its material and its journey after disposal.",
  ),
  const Item(
    name: 'Burger',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: AssetImage('assets/burger.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, looks like this burger's journey has been cut short! Consider where its remaining 'half' belongs",
  ),
  const Item(
    name: 'Cardboard Box',
    totalPriceCents: 1499,
    uid: '4',
    imageProvider: AssetImage('assets/cardboard_box.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hmm, this one might need a sturdier home. Think about where you'd put it for a new life.",
  ),
  const Item(
    name: 'Charging Cable',
    totalPriceCents: 1499,
    uid: '5',
    imageProvider: AssetImage('assets/charging_cable.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoopsie! This item needs a charge of its own, but in a different bin. Consider its technological nature.",
  ),
  const Item(
    name: 'Disposable Cup',
    totalPriceCents: 1499,
    uid: '6',
    imageProvider: AssetImage('assets/disposable_cup.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh dear, this cup's journey might be a bit different than you think. Reflect on its composition.",
  ),
  const Item(
    name: 'Egg Shells',
    totalPriceCents: 1499,
    uid: '7',
    imageProvider: AssetImage('assets/egg_shells.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hm, this one's a bit 'shell'-shocked! Imagine where it belongs after its 'cracking' adventure.",
  ),
  const Item(
    name: 'Food Leftover',
    totalPriceCents: 1499,
    uid: '8',
    imageProvider: AssetImage('assets/food_leftover.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Ah, leftovers from a journey! But perhaps a different destination awaits them. Consider their origins.",
  ),
  const Item(
    name: 'Fruit Scraps',
    totalPriceCents: 1499,
    uid: '9',
    imageProvider: AssetImage('assets/fruit_scraps.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hmm, these scraps may lead to a fruitful destination elsewhere. Ponder their potential.",
  ),
  const Item(
    name: 'Game Console',
    totalPriceCents: 1499,
    uid: '10',
    imageProvider: AssetImage('assets/game_console.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoa, a gaming device! But its journey might be to a different bin. Imagine where it 'resets'.",
  ),
  const Item(
    name: 'Keyboard',
    totalPriceCents: 1499,
    uid: '11',
    imageProvider: AssetImage('assets/keyboard.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Oops, seems like this keyboard needs a different key to its journey. Reflect on its functionality.",
  ),
  const Item(
    name: 'Mask',
    totalPriceCents: 1499,
    uid: '12',
    imageProvider: AssetImage('assets/mask.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Ah, a mask! But perhaps a different bin awaits it for a new journey. Consider its protective purpose.",
  ),
  const Item(
    name: 'Mouse',
    totalPriceCents: 1499,
    uid: '13',
    imageProvider: AssetImage('assets/mouse.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Squeak! This mouse's journey might lead it to a different bin. Imagine where it 'clicks'.",
  ),
  const Item(
    name: 'Newspapers',
    totalPriceCents: 1499,
    uid: '14',
    imageProvider: AssetImage('assets/newspaper.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hm, this news needs a new destination. Think about where it belongs after being 'read'.",
  ),
  const Item(
    name: 'Plastic Bottle',
    totalPriceCents: 1499,
    uid: '15',
    imageProvider: AssetImage('assets/pastic_bottle.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh, a bottle! But where does it go after quenching its thirst? Imagine its next adventure.",
  ),
  const Item(
    name: 'Broken Phone',
    totalPriceCents: 1499,
    uid: '16',
    imageProvider: AssetImage('assets/phone.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Uh-oh, this phone's journey might need a new 'connection'. Think about where its 'broken' parts should go for a new life",
  ),
  const Item(
    name: 'Sanitary Napkins',
    totalPriceCents: 1499,
    uid: '17',
    imageProvider: AssetImage('assets/sanitary_napkins.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Whoops, this item might need a different destination. Reflect on its hygiene purpose.",
  ),
  const Item(
    name: 'Tampons',
    totalPriceCents: 1499,
    uid: '18',
    imageProvider: AssetImage('assets/tampons.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Hmm, these might need a different bin for their next 'cycle'. Imagine where they belong.",
  ),
  const Item(
    name: 'Tea Bags',
    totalPriceCents: 1499,
    uid: '19',
    imageProvider: AssetImage('assets/tea_bags.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, these bags might need a different brew of a bin. Ponder their compostable potential",
  )
];
