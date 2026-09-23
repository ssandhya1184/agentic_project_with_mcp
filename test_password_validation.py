import pytest

from password_validation import validate_password


@pytest.mark.parametrize(
    "password",
    ["ValidPass1!", "Abcdefg9@", "Zx123456#Password"],
)
def test_accepts_valid_passwords(password: str) -> None:
    assert validate_password(password) is True


@pytest.mark.parametrize(
    "password",
    [
        None,
        "",
        "Short1!",
        "ThisPasswordIsTooLong1!",
        "lowercase1!",
        "UPPERCASE1!",
        "NoDigits!",
        "NoSpecial1",
        "Has Space1!",
        "Has\tTab1!",
    ],
)
def test_rejects_invalid_passwords(password: str | None) -> None:
    assert validate_password(password) is False


def test_accepts_all_supported_special_characters() -> None:
    assert validate_password("Abcdef1@#$%^&*!") is True
