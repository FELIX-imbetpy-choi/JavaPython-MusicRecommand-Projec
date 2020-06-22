package com.semi.funtion;

import java.util.ArrayList;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class function {
    public REXP rx = null;
    public RConnection rCon = null;
    public String retStr = "";

    // constructor
    public function() {
        
    }
    
    public ArrayList<String> RrandomForestRegressor(String id) throws RserveException, REXPMismatchException{
        rCon = new RConnection("192.168.99.100", 6311); // 내 도커 IP, 포트주소
        
        String userid = id;
        ArrayList<String> seqnums = new ArrayList<String>();
        
        rCon.eval("library(randomForest)");
        rCon.eval("library(RMySQL)");
        rCon.eval("library(caret)");
        rCon.eval("conn <- dbConnect(MySQL(), dbname = \"honjoc\", user = \"root\", password = \"1111\", host = \"192.168.101.106\")");        
        rCon.eval("id <- '\""+userid+"\"'"); // 변수로 안받고 바로 select문에 userid써주면 에러걸림
        rCon.eval("song100 <- dbGetQuery(conn, paste('select popularity, acousticness, danceability, duration_ms, energy, instrumentalness, liveness, loudness, speechiness, tempo, time_signature, valence, sum(counts) as counts from music, log_play where log_play.l_uid =',id,' and log_play.l_seq = music.seq group by log_play.l_seq'))");
        rCon.eval("test <- dbGetQuery(conn, paste('select popularity, acousticness, danceability, duration_ms, energy, instrumentalness, liveness, loudness, speechiness, tempo, time_signature, valence from music where seq not in (select l_seq from log_play where l_uid =',id,')'))");
        
        rCon.eval("rf <- randomForest(counts ~ ., data = song100, ntree = 100)");
        
        rCon.eval("pred <- predict(rf, test)");
        rCon.eval("df <- as.data.frame(sort(pred,decreasing = TRUE))");
         
        rCon.eval("df2 <- cbind(df,row.names(df))");
        rCon.eval("colnames(df2) <- c('result','musicseq')");
        rCon.eval("head(df2,10)");

        String seq1 = rCon.eval("df2$musicseq[1]").asString();
        String seq2 = rCon.eval("df2$musicseq[2]").asString();
        String seq3 = rCon.eval("df2$musicseq[3]").asString();
        String seq4 = rCon.eval("df2$musicseq[4]").asString();
        String seq5 = rCon.eval("df2$musicseq[5]").asString();
        String seq6 = rCon.eval("df2$musicseq[6]").asString();
        String seq7 = rCon.eval("df2$musicseq[7]").asString();
        String seq8 = rCon.eval("df2$musicseq[8]").asString();

        seqnums.add(seq1);
        seqnums.add(seq2);
        seqnums.add(seq3);
        seqnums.add(seq4);
        seqnums.add(seq5);
        seqnums.add(seq6);
        seqnums.add(seq7);
        seqnums.add(seq8);
        rCon.close();
        return seqnums;
        
    }
}