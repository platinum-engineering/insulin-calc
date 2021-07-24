import pytest
import logging


@pytest.fixture(scope="module")
def storage1(accounts, EventStorage):
    s = accounts[0].deploy(EventStorage, "0.0.1")
    yield s


