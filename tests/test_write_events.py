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

    
def test_get_insulins(accounts, storage1):
    logging.info(storage1.getInsulins())
    assert len(storage1.getInsulins()) == 3

def test_save_personal_insulin(accounts, storage1):
    storage1.addPersonalInsulin('personal_insulin 1', {'from': accounts[0]})
    storage1.addPersonalInsulin('personal_insulin 2', {'from': accounts[0]})
    storage1.addPersonalInsulin('personal_insulin 3', {'from': accounts[0]})
    assert len(storage1.getPersonalInsulins(accounts[0]))==3

def test_get_all_insulin(accounts, storage1):
    logging.info(storage1.getAllInsulins())
    assert len(storage1.getAllInsulins())==6

def test_remove_personal_insulin(accounts, storage1):
    storage1.removePersonalInsulin(1, {'from': accounts[0]})
    assert len(storage1.getPersonalInsulins(accounts[0]))==2
    logging.info(storage1.getAllInsulins())     