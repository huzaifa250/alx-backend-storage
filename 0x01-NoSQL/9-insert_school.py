#!/usr/bin/env python3
"""Module has a utility function that insert documents"""
import pymongo


def insert_school(mongo_collection, **kwargs):
    """insert into school"""
    return mongo_collection.insert_one(kwargs).inserted_id
