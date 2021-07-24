import pytest
import logging
from brownie import *

LOGGER = logging.getLogger(__name__)

MEASURE_RECORD =  [58,50,6,('Novorapid',3)]

def test_write_event(accounts, storage1):
    tx = storage1.writeMeasure(
        chain.time(),
        MEASURE_RECORD[0],
        MEASURE_RECORD[1],
        MEASURE_RECORD[2],
        MEASURE_RECORD[3]
    )
    logging.info(tx.events['MeasureRecord'])    
    assert len(tx.events) == 1

def test_read_web3(accounts, storage1):
    
