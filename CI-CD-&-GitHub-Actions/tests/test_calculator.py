import pytest

from app.calculator import add, calculate, divide, multiply, subtract


def test_add():
    assert add(10, 5) == 15


def test_subtract():
    assert subtract(10, 5) == 5


def test_multiply():
    assert multiply(10, 5) == 50


def test_divide():
    assert divide(10, 5) == 2


def test_divide_by_zero():
    with pytest.raises(ValueError):
        divide(10, 0)


def test_calculate_by_name():
    assert calculate("multiply", 3, 4) == 12


def test_calculate_unknown_operation():
    with pytest.raises(ValueError):
        calculate("power", 2, 3)
