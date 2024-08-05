
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import NoSuchElementException
import time
import psycopg2
import re

i = 1
conn = psycopg2.connect(host='localhost', dbname='dayseop',user='postgres',password='1234',port=5432)
conn.autocommit = True
cur = conn.cursor()
cur.execute("DROP TABLE cpu_Product")
cur.execute("CREATE TABLE cpu_Product(name VARCHAR(255) PRIMARY KEY, price INT, cpu_cache numeric(4,2), cpu_core INT, cpu_socket VARCHAR(255), url VARCHAR(255), image VARCHAR(255))")

while True:

    options = webdriver.ChromeOptions()
    UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"   
    options.add_argument('user-agent' + UserAgent)
    driver = webdriver.Chrome()
    driver.get(url = 'https://search.danawa.com/dsearch.php?query=CPU&originalQuery=CPU&previousKeyword=CPU&excludeKeyword=%ED%95%B4%EC%99%B8%EA%B5%AC%EB%A7%A4%7C%EC%A4%91%EA%B3%A0%7C%EB%A0%8C%ED%83%88&isShortcut=true&volumeType=vmvs&page='+str(i)+'&limit=40&sort=saveDESC&list=list&boost=true&addDelivery=N&maker=3132,3156&mode=simple&recommendedSort=Y&defaultUICategoryCode=113973&defaultPhysicsCategoryCode=861%7C873%7C959%7C0&defaultVmTab=38826&defaultVaTab=389380&isZeroPrice=N&tab=main')

    time.sleep(5)
    try:
        prod = driver.find_element(By.CLASS_NAME, 'product_list')       #자료가 없을때 exception을 발생시키기 위함
        product = driver.find_elements(By.CLASS_NAME, 'product_list')   #자료가 없어도 공간은 생기므로 exception이 발생하지 않게 됨           
        for prd in product:    
            lis = prd.find_elements(By.CLASS_NAME, 'prod_main_info')

            for li in lis:
                try:
                    name = li.find_element(By.CLASS_NAME, 'prod_name').text
                    pricesect = li.find_element(By.CLASS_NAME, 'price_sect')
                    price1 = pricesect.find_element(By.TAG_NAME, 'a').text
                    price = re.sub(r"[^0-9]", "", price1)
                    spec = li.find_element(By.CLASS_NAME, 'spec_list').text
                    urlsect = li.find_element(By.CLASS_NAME, 'prod_name')
                    url = urlsect.find_element(By.TAG_NAME, 'a').get_attribute('href')
                    imagesect1 = li.find_element(By.CLASS_NAME, 'thumb_image')
                    image = imagesect1.find_element(By.TAG_NAME, 'img').get_attribute('src')

                    if image == 'https://img.danawa.com/new/noData/img/noImg_160.gif':
                        image = imagesect1.find_element(By.TAG_NAME, 'img').get_attribute('data-src')                   
                    if name:                    
                        
                        a1 = re.sub(r"[^0-9/^L/^.]", "", spec)
                        a2 = a1.split('/')
                        a3 = [word for word in a2 if 'L2' in word]
                        a4 = '/'.join(a3)
                        a5 = re.sub("L2", "", a4)
                        cpu_cache = re.sub(r"[^0-9/^.]", "", a5)
                                               
                        b1 = re.sub(r"[^0-9/^코어$/^+]", "", spec)
                        b2 = b1.split('/')
                        b3 = [word for word in b2 if '코어' in word]
                        b4 = '/'.join(b3)
                        b5 = re.sub(r"[^0-9/^+]", "", b4)
                        cpu_core = b5
                        for j in range(len(b5)):
                            if(b5[j] == '+'):
                                int(b5[:j])
                                int(b5[j:])
                                cpu_core = int(b5[:j]) + int(b5[j:])
                                            
                        c1 = re.sub(r"[^0-9/^AM$/^AMD$/^인텔$/^소켓$]", "", spec)
                        c2 = c1.split('/')
                        c3 = [word for word in c2 if '소켓' in word]
                        c4 = '/'.join(c3)
                        cpu_socket = re.sub(r"[^0-9/^가-힣/^A-Z]", "", c4)

                        
                        # print(name)
                        # print(price)
                        # print(cpu_cache)
                        # print(cpu_core) 
                        # print(cpu_socket)
                        # print(url)
                        # print(image)

                        insertcur = ("INSERT INTO cpu_Product (name, price, cpu_cache, cpu_core, cpu_socket, url, image) VALUES (%s, %s, %s, %s, %s, %s, %s)")
                        data = (name, price, cpu_cache, cpu_core, cpu_socket, url, image)
                        cur.execute(insertcur, data)

                except Exception:
                    pass

        print ('*' * 50 + ' ' + str(i) + 'Page End!' + ' ' + '*' * 50)
        time.sleep(5)
        i += 1
        driver.quit()

    except NoSuchElementException:
        exit(0)
# '6+4' 코어 같은 형식의 자료들 정리하거나 코어를 분류기준에서 제거
# L2캐시 없는것들이 꽤 있어서 제외된것만 40개넘을듯