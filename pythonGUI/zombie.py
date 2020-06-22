import sys
from PyQt5.QtWidgets import *
from PyQt5 import QtCore
from PyQt5.QtGui import *
import numpy as np
import pandas as pd
import urllib.request as req
from bs4 import BeautifulSoup
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics

cid ="18036c9769a64a9488a17419863beb3b" 
secret = "6dfa96c4f860468f8bf4a796e2b90df6"

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

class MyWindow(QMainWindow):
    def __init__(self): # self(class안에 있는것들만 사용한다)
        super().__init__()
        self.setupUI()
    # Window Widget
    def setupUI(self):
        # Window Title
        self.setWindowTitle("Spotify") # window title
        self.setWindowIcon(QIcon('icon.png'))
        self.setGeometry(700,400,400,300)

        # Label Text
        textLabel1 = QLabel("Spotify 음악정보 Scraping 하기", self)
        textLabel1.move(40,30)
        textLabel1.resize(250,30)
        textLabel2 = QLabel("년도 :", self)
        textLabel2.move(40,80)

        # Line Edit
        self.lineEdit = QLineEdit("",self)
        self.lineEdit.move(180,80)
        self.lineEdit.resize(170,30)

        # Label Data
        self.label = QLabel("결과 : ",self)
        self.label.move(150,160)
        self.label.resize(250,100) # width, height

        
        # lineEdit의 텍스트가 변경될때
        # self.lineEdit.textChanged.connect(self.lineEditChanged)
        # lineEdit에서 Enter를 눌렀을때
        # self.lineEdit.returnPressed.connect(self.lineEditChanged)
        # lineEdit에서 Button을 클릭할때

        # Button1
        btn1 = QPushButton("CSV 만들기", self)
        btn1.move(30,120)
        btn1.clicked.connect(self.spotify) # 버튼을 클릭하면 아래의 btn1_clicked출력
        btn1.clicked.connect(self.btn1_clicked)

        # Button2
        btn2 = QPushButton("Clustering", self)
        btn2.move(140,120)
        btn2.clicked.connect(self.cluster) # 버튼을 클릭하면 아래의 btn2_clicked출력
        btn2.clicked.connect(self.btn2_clicked)

        # # Button3
        # btn3 = QPushButton("DB 저장하기", self)
        # btn3.move(250,120)
        # btn3.clicked.connect(self.db) # 버튼을 클릭하면 아래의 btn2_clicked출력
        # btn3.clicked.connect(self.btn3_clicked)

    # Button Event
    def btn1_clicked(self):
        self.label.setText("  CSV로 저장되었습니다.")

    def btn2_clicked(self):
        self.label.setText("  Clustering완료후 DB로 저장 되었습니다.")

    # def btn3_clicked(self):
    #     self.label.setText("  DB로 저장되었습니다.")    

    # HTML
    def spotify(self):
        import timeit
        start = timeit.default_timer()

        # create empty lists where the results are going to be stored
        artist_name = []
        track_name = []
        popularity = []
        track_id = []
        spotify_href = []
        images = []
        release_date = []

        # limit: a maximum of 50 results can be returned per query
        # offset: this is the index of the first result to return, 
        # so if you want to get the results with the index 50-100 you will need to set the offset to 50 etc.
        for i in range(0,1000,50):
            track_results = sp.search(q='year:'+str(self.lineEdit.text()), type='track', limit=50,offset=i)
            for i, t in enumerate(track_results['tracks']['items']):
                artist_name.append(t['artists'][0]['name'])
                track_name.append(t['name'])
                track_id.append(t['id'])
                popularity.append(t['popularity'])
                spotify_href.append(t['external_urls']['spotify'])
                try:
                    images.append(t['album']['images'][1]['url'])
                except:
                    images.append('')
                release_date.append(t['album']['release_date'])
            print(i)
                    
        stop = timeit.default_timer()
        print ('Time to run this code (in seconds):', stop - start)
        df_tracks = pd.DataFrame({'artist_name':artist_name,'track_name':track_name,'track_id':track_id,'popularity':popularity,
                         'url':spotify_href,'images':images,'date':release_date})
        grouped = df_tracks.groupby(['artist_name','track_name'], as_index=True).size()
        df_tracks.drop_duplicates(subset=['artist_name','track_name'], inplace=True)
        grouped_after_dropping = df_tracks.groupby(['artist_name','track_name'], as_index=True).size()
        # again measuring the time
        start = timeit.default_timer()

        # empty list, batchsize and the counter for None results
        rows = []
        batchsize = 100
        None_counter = 0

        for i in range(0,len(df_tracks['track_id']),batchsize):
            batch = df_tracks['track_id'][i:i+batchsize]
            feature_results = sp.audio_features(batch)
            for i, t in enumerate(feature_results):
                if t == None:
                    None_counter = None_counter + 1
                else:
                    rows.append(t)
                    
        print('Number of tracks where no audio features were available:',None_counter)

        stop = timeit.default_timer()
        print ('Time to run this code (in seconds):',stop - start)
        df_audio_features = pd.DataFrame.from_dict(rows,orient='columns')  
        columns_to_drop = ['analysis_url','track_href','type','uri']
        df_audio_features.drop(columns_to_drop, axis=1,inplace=True)
        df_audio_features.rename(columns={'id': 'track_id'}, inplace=True)
        df = pd.merge(df_tracks,df_audio_features,on='track_id',how='inner')
        df.to_csv('./spotifyLists_' +self.lineEdit.text()+'.csv', encoding='utf-8',index=False)
        
    
    def cluster(self):
        df1 = pd.read_csv('./song.csv')
        df2 = pd.read_csv('./spotifyLists_' +self.lineEdit.text()+'.csv')    
        df1_data = df1[['popularity']]
        df2_data = df1[['loudness']]
        df3_data = df1[['tempo']]
        df4_data = df1[['time_signature']]
        df5_data = df1[['acousticness']]
        df6_data = df1[['danceability']]
        df7_data = df1[['energy']]
        df8_data = df1[['instrumentalness']]
        df9_data = df1[['liveness']]
        df10_data = df1[['speechiness']]
        df11_data = df1[['valence']]
        df12_data = df1[['key']]

        df1_label = df1[['clst_popularity']]
        df2_label = df1[['clst_loudness']]
        df3_label = df1[['clst_tempo']]
        df4_label = df1[['clst_time_signature']]
        df5_label = df1[['clst_acoustic']]
        df6_label = df1[['clst_danceability']]
        df7_label = df1[['clst_energy']]
        df8_label = df1[['clst_instrumentalness']]
        df9_label = df1[['clst_liveness']]
        df10_label = df1[['clst_speechiness']]
        df11_label = df1[['clst_valence']]
        df12_label = df1[['clst_key']]


        df1_data2 = df2[['popularity']]
        df2_data2 = df2[['loudness']]
        df3_data2 = df2[['tempo']]
        df4_data2 = df2[['time_signature']]
        df5_data2 = df2[['acousticness']]
        df6_data2 = df2[['danceability']]
        df7_data2 = df2[['energy']]
        df8_data2 = df2[['instrumentalness']]
        df9_data2 = df2[['liveness']]
        df10_data2 = df2[['speechiness']]
        df11_data2 = df2[['valence']]
        df12_data2 = df2[['key']]
        
        rf_clf1 = RandomForestClassifier()
        rf_clf2 = RandomForestClassifier()
        rf_clf3 = RandomForestClassifier()
        rf_clf4 = RandomForestClassifier()
        rf_clf5 = RandomForestClassifier()
        rf_clf6 = RandomForestClassifier()
        rf_clf7 = RandomForestClassifier()
        rf_clf8 = RandomForestClassifier()
        rf_clf9 = RandomForestClassifier()
        rf_clf10 = RandomForestClassifier()
        rf_clf11 = RandomForestClassifier()
        rf_clf12 = RandomForestClassifier()

        rf_clf1.fit(df1_data,df1_label)
        rf_clf2.fit(df2_data,df2_label)
        rf_clf3.fit(df3_data,df3_label)
        rf_clf4.fit(df4_data,df4_label)
        rf_clf5.fit(df5_data,df5_label)
        rf_clf6.fit(df6_data,df6_label)
        rf_clf7.fit(df7_data,df7_label)
        rf_clf8.fit(df8_data,df8_label)
        rf_clf9.fit(df9_data,df9_label)
        rf_clf10.fit(df10_data,df10_label)
        rf_clf11.fit(df11_data,df11_label)
        rf_clf12.fit(df12_data,df12_label)


        rf_pre1 = rf_clf1.predict(df1_data2)
        rf_pre2 = rf_clf2.predict(df2_data2)
        rf_pre3 = rf_clf3.predict(df3_data2)
        rf_pre4 = rf_clf4.predict(df4_data2)
        rf_pre5 = rf_clf5.predict(df5_data2)
        rf_pre6 = rf_clf6.predict(df6_data2)
        rf_pre7 = rf_clf7.predict(df7_data2)
        rf_pre8 = rf_clf8.predict(df8_data2)
        rf_pre9 = rf_clf9.predict(df9_data2)
        rf_pre10 = rf_clf10.predict(df10_data2)
        rf_pre11 = rf_clf11.predict(df11_data2)
        rf_pre12 = rf_clf12.predict(df12_data2)

        df2['clst_popularity'] =  rf_pre1
        df2['clst_loudness'] =  rf_pre2
        df2['clst_tempo'] =  rf_pre3
        df2['clst_time_signature'] =  rf_pre4
        df2['clst_acoustic'] =  rf_pre5
        df2['clst_danceability'] =  rf_pre6
        df2['clst_energy'] =  rf_pre7
        df2['clst_instrumentalness'] =  rf_pre8
        df2['clst_liveness'] =  rf_pre9
        df2['clst_speechiness'] =  rf_pre10
        df2['clst_valence'] =  rf_pre11
        df2['clst_key'] =  rf_pre12
        
        df2['clst_category'] = \
        df2['clst_loudness'].astype("str") + \
        df2['clst_tempo'].astype("str") + \
        df2['clst_acoustic'].astype("str") + \
        df2['clst_speechiness'].astype("str") +  \
        df2['clst_instrumentalness'].astype("str") + \
        df2['clst_danceability'].astype("str") + \
        df2['clst_valence'].astype("str") 
        
        # df2.to_csv('./spotifyLists_' +self.lineEdit.text()+'.csv', encoding='utf-8',index=False)

    # def db(self):
        import pymysql
        from sqlalchemy import create_engine
        column = colnames = ['artist_name','track_name','track_id','popularity','url','images','date','acousticness',
                     'danceability','duration_ms','energy','instrumentalness','key','liveness','loudness','mode','speechiness','tempo','time_signature',
                     'valence','clst_popularity','clst_loudness','clst_tempo',
                     'clst_time_signature','clst_acoustic',
                     'clst_danceability','clst_energy','clst_instrumentalness','clst_liveness','clst_speechiness',
                     'clst_valence','clst_key','clst_category'
                     ]
        # df = pd.read_csv('./spotifyLists_' +self.lineEdit.text()+'.csv')
        # df = pd.DataFrame(df)
        df2.columns = column
        engine = create_engine("mysql+pymysql://root:" + "1111" + 
                       "@192.168.101.106:3306/honjoc?charset=utf8",
                      encoding = 'utf-8')
        conn = engine.connect()

        df2.to_sql(name = 'music', con = engine, if_exists = 'append', index = False)
        conn.close()
if __name__ == "__main__":
    app = QApplication(sys.argv)
    mywindow = MyWindow() # 사용할 클래스명
    mywindow.show()
    app.exec_()

