from pathlib import Path

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title

BAT = Path("/sys/class/power_supply/BAT0")  # verify: ls /sys/class/power_supply/
_timer = None


def _read(name: str) -> str:
    try:
        return (BAT / name).read_text().strip()
    except OSError:
        return "?"


def _refresh(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global _timer
    if _timer is None:
        _timer = add_timer(_refresh, 30.0, True)  # redraw every 30 s

    draw_title(draw_data, screen, tab, index, max_title_length)
    screen.draw(" ")
    if is_last:
        text = f" {_read('capacity')}% {_read('status')} "
        screen.cursor.x = max(screen.cursor.x, screen.columns - len(text))
        screen.draw(text)
    return screen.cursor.x
