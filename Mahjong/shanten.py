from mahjong.hand_calculating.hand import HandCalculator
from mahjong.meld import Meld
from mahjong.hand_calculating.hand_config import HandConfig, OptionalRules
from mahjong.shanten import Shanten
from mahjong.tile import TilesConverter
from mahjong.locale.text_reporter import TextReporter
import sys




# useful helper with locale
def print_hand_result(hand_result, locale='Japanese'):   # 'Chinese' / 'Japanese'
    reporter = TextReporter(locale=locale)
    str_dict = reporter.report(hand_result)

    if hand_result.error:
        print(str_dict['error'])
    else:
        print(str_dict['fu_details'])
        print(str_dict['yaku'])
        print(str_dict['cost'])

    print('')

####################################################################
# Shanten calculation                                              #
####################################################################

calculator = HandCalculator()
shanten = Shanten()
tiles = TilesConverter.string_to_34_array(man=sys.argv[1], pin=sys.argv[2], sou=sys.argv[3],honors=sys.argv[4])
result = shanten.calculate_shanten(tiles)

print(result)
