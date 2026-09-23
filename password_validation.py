"""Validate passwords against the SCRUM-6 requirements."""


_SPECIAL_CHARACTERS = "@#$%^&*!"


def validate_password(password: str | None) -> bool:
    """Return whether password satisfies the required validation rules."""
    if password is None or not password or not 8 <= len(password) <= 20:
        return False
    if any(character.isspace() for character in password):
        return False

    return (
        any(character.isupper() for character in password)
        and any(character.islower() for character in password)
        and any(character.isdigit() for character in password)
        and any(character in _SPECIAL_CHARACTERS for character in password)
    )
