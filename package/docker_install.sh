virtualenv --python=/usr/bin/python3.8 python
source python/bin/activate
# pip install -r requirements.txt -t python/lib/python3.8/site-packages
pip install -r requirements.txt -t python/

zip -r9 python.zip python