import pytest
import logging
from brownie import *

LOGGER = logging.getLogger(__name__)

MEASURE_RECORD =  [58,50,6,('Novorapid',3)]

def test_write_event(accounts, storage1):
    tx = storage1.bolus(
        chain.time(),
        MEASURE_RECORD[0],
        MEASURE_RECORD[1],
        MEASURE_RECORD[2],
        MEASURE_RECORD[3]
    )
    logging.info(tx.events['MeasureRecord'])    
    assert len(tx.events) == 1
    assert tx.events['MeasureRecord']['glucose'] == MEASURE_RECORD[0]
    assert tx.events['MeasureRecord']['carbs'] == MEASURE_RECORD[1]
    assert tx.events['MeasureRecord']['units'] == MEASURE_RECORD[2]
    assert tx.events['MeasureRecord']['insulinType'] == MEASURE_RECORD[3]

    
