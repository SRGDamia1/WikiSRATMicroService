schema = {
    "type": "array",
    "items": {
        "type": "object",
        "properties": {
            "huc12": {"type": "integer", "minimum": 0, "maximum": 999999999999},
            "tpload_hp": {"type": "number"},
            "tpload_Crop": {"type": "number"},
            "tpload_Wooded": {"type": "number"},
            "tpload_Open": {"type": "number"},
            "tpload_barren": {"type": "number"},
            "tpload_ldm": {"type": "number"},
            "tpload_MDM": {"type": "number"},
            "tpload_HDM": {"type": "number"},
            "tpload_OtherUp": {"type": "number"},
            "tpload_FarmAn": {"type": "number"},
            "tpload_tiledrain": {"type": "number"},
            "tpload_streambank": {"type": "number"},
            "tpload_subsurface": {"type": "number"},
            "tpload_pointsource": {"type": "number"},
            "tpload_septics": {"type": "number"},
            "tnload_hp": {"type": "number"},
            "tnload_crop": {"type": "number"},
            "tnload_wooded": {"type": "number"},
            "tnload_open": {"type": "number"},
            "tnload_barren": {"type": "number"},
            "tnload_ldm": {"type": "number"},
            "tnload_mdm": {"type": "number"},
            "tnload_hdm": {"type": "number"},
            "tnload_otherup": {"type": "number"},
            "tnload_farman": {"type": "number"},
            "tnload_tiledrain": {"type": "number"},
            "tnload_streambank": {"type": "number"},
            "tnload_subsurface": {"type": "number"},
            "tnload_pointsource": {"type": "number"},
            "tnload_septics": {"type": "number"},
            "tssload_hp": {"type": "number"},
            "tssload_crop": {"type": "number"},
            "tssload_wooded": {"type": "number"},
            "tssload_open": {"type": "number"},
            "tssload_barren": {"type": "number"},
            "tssload_ldm": {"type": "number"},
            "tssload_mdm": {"type": "number"},
            "tssload_hdm": {"type": "number"},
            "tssload_otherup": {"type": "number"},
            "tssload_tiledrain": {"type": "number"},
            "tssload_streambank": {"type": "number"}
        },
        "additionalProperties": False,
        "required": [
            "huc12",
            "tpload_hp",
            "tpload_Crop",
            "tpload_Wooded",
            "tpload_Open",
            "tpload_barren",
            "tpload_ldm",
            "tpload_MDM",
            "tpload_HDM",
            "tpload_OtherUp",
            "tpload_FarmAn",
            "tpload_tiledrain",
            "tpload_streambank",
            "tpload_subsurface",
            "tpload_pointsource",
            "tpload_septics",
            "tnload_hp",
            "tnload_crop",
            "tnload_wooded",
            "tnload_open",
            "tnload_barren",
            "tnload_ldm",
            "tnload_mdm",
            "tnload_hdm",
            "tnload_otherup",
            "tnload_farman",
            "tnload_tiledrain",
            "tnload_streambank",
            "tnload_subsurface",
            "tnload_pointsource",
            "tnload_septics",
            "tssload_hp",
            "tssload_crop",
            "tssload_wooded",
            "tssload_open",
            "tssload_barren",
            "tssload_ldm",
            "tssload_mdm",
            "tssload_hdm",
            "tssload_otherup",
            "tssload_tiledrain",
            "tssload_streambank"]
    }
}

column_numbers = {
    "huc12": 0,
    "tpload_hp": 1,
    "tpload_Crop": 2,
    "tpload_Wooded": 3,
    "tpload_Open": 4,
    "tpload_barren": 5,
    "tpload_ldm": 6,
    "tpload_MDM": 7,
    "tpload_HDM": 8,
    "tpload_OtherUp": 9,
    "tpload_FarmAn": 10,
    "tpload_tiledrain": 11,
    "tpload_streambank": 12,
    "tpload_subsurface": 13,
    "tpload_pointsource": 14,
    "tpload_septics": 15,
    "tnload_hp": 16,
    "tnload_crop": 17,
    "tnload_wooded": 18,
    "tnload_open": 19,
    "tnload_barren": 20,
    "tnload_ldm": 21,
    "tnload_mdm": 22,
    "tnload_hdm": 23,
    "tnload_otherup": 24,
    "tnload_farman": 25,
    "tnload_tiledrain": 26,
    "tnload_streambank": 27,
    "tnload_subsurface": 28,
    "tnload_pointsource": 29,
    "tnload_septics": 30,
    "tssload_hp": 31,
    "tssload_crop": 32,
    "tssload_wooded": 33,
    "tssload_open": 34,
    "tssload_barren": 35,
    "tssload_ldm": 36,
    "tssload_mdm": 37,
    "tssload_hdm": 38,
    "tssload_otherup": 39,
    "tssload_tiledrain": 40,
    "tssload_streambank": 41,
}