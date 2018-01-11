import psycopg2
from constants import column_numbers


class DatabaseAdapter:
    def __init__(self, db_in, user_in, host_in, port_in, password_in):
        try:
            self.conn = psycopg2.connect(database=db_in, user=user_in, host=host_in, port=port_in, password=password_in)
        except psycopg2.OperationalError as e:
            raise AttributeError("unable to connect to datbase")

    @classmethod
    def python_to_array(self, python_object):
        result = []
        for _ in range(0, len(column_numbers)):  # create an array of arrays without numpy
            result.append([])
        for huc12 in python_object:
            for attribute, value in huc12.items():
                result[column_numbers[attribute]].append(value)
        return result

    @classmethod
    def array_to_python(self, array):
        result = []
        column_number_to_name = dict((v, k) for k, v in column_numbers.items())
        for _ in range(0, len(array[0])):
            result.append({})  # prep the right number of empty huc12 objects
        for i, attribute_array in enumerate(array):
            for j, attribute in enumerate(attribute_array):
                result[j][column_number_to_name[i]] = attribute
        return result

    @classmethod
    def run_model(self, input_array):
        """input is the array of data, output should be the result of the query"""
        return "output string"