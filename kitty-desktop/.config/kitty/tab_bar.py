# ~/.config/kitty/tab_bar.py
import time
from pathlib import Path

from kitty.boss import get_boss
from kitty.fast_data_types import add_timer
from kitty.tab_bar import draw_tab_with_powerline

BAT = Path('/sys/class/power_supply/BAT0')      # verify: ls /sys/class/power_supply/
_timer = None


def _bat() -> str:
    try:
        return f'{(BAT / "capacity").read_text().strip()}%'
    except OSError:
        return '?'


def _redraw(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()


def draw_tab(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data):
    global _timer
    if _timer is None:
        _timer = add_timer(_redraw, 30.0, True)
    end = draw_tab_with_powerline(draw_data, screen, tab, before, max_title_length,
                                  index, is_last, extra_data)
    if is_last:
        text = f' {_bat()} | {time.strftime("%a %d.%m. %H:%M")} '
        if screen.cursor.x < screen.columns - len(text):
            screen.cursor.x = screen.columns - len(text)
            screen.draw(text)
            end = screen.cursor.x
    return end
