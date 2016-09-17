#ifndef _MyLib_h
#define _MyLib_h

#ifdef ARDUINO_ARCH_ESP8266   // this macro is defined by Arduio IDE
#else
#define MYLIB_ARDUINO
#endif


#ifdef MYLIB_ARDUINO
#else
#include <ESP8266WiFi.h>
#include <FS.h>
#endif

#include <TimeLib.h>

void updateDDNS();

String URLEncode(String smsg);

#define THIS_SKETCH getThisSketch(__FILE__,__DATE__,__TIME__)
String getThisSketch(const char *src, const char *date, const char *time);

void printSystemInfo();
String getSystemInfo();
String getFSInfo();

//int checkInterval(int interval);
//int checkInterval2(int interval);

time_t getNow();
String getDateTime(time_t tm);
String getDateTimeNow();

String getStatus();

bool WiFiConnect();
bool WiFiConnect(const char *ssid, const char *password);

class CheckInterval {
 public:
  CheckInterval(unsigned long interval);
  bool check();
  void set(unsigned long interval);
  unsigned long get() {return _interval;}
 private:
  unsigned long _interval;
  unsigned long _prev;
};
//extern CheckInterval CI;

#ifdef MYLIB_ARDUINO
#else

class FTPClient {
 public:
  FTPClient();
  ~FTPClient();
  int open(String server, String user, String pass);
  int cd(String dirName);
  int pwd();// TODO:
  int ls();
  int get(String fileName);
  int put(String fileName);
  int append(String fileName);
  int bye();
  String reply; // latest reply string from server
 private:
  String _serverIP;
  WiFiClient _cclient;
  WiFiClient _dclient;
  String getReply();
  void sendCmd(String cmd);
  int getPortFromPASVReply(String reply);
  int put_internal(String fileName, String cmd);
};


bool fileCopy(const char *path1, const char *path2);
bool fileAppend(const char *path, const char *contents);

#endif

class LogFile : public Print {
   public:
	LogFile(String fileName);
	LogFile(String fileName, int maxFileSize);
	void set(String fileName);
	void set(String fileName, int maxFileSize);
	String fileName() { return _fileName; }
	virtual size_t write(uint8_t); // override Print class
	virtual size_t write(const uint8_t *buffer, size_t size); // override Print class
   private:
        int _maxSize = 1000000000;
        int _size = 0;
        String _fileName;
};


class DebugOutClass : public Print {
   public:
	DebugOutClass() : _type(0), _type_prev(0), _logFile("/debugout_log.txt",100000) {}
	void setToSerial(){_type_prev=_type; _type=0;}
	void setToNull(){_type_prev=_type; _type=1;}
	void setToFile(){ _type_prev=_type; _type=2; } // dont change file name
	void setToFile(String file){ setToFile(); _logFile.set(file); }
	void setToFile(String file, int maxSize){ setToFile(); _logFile.set(file, maxSize); }
  	void setToPrevious(){ int t=_type; _type=_type_prev; _type_prev = t; }
	String FileName() { return _logFile.fileName(); }
	virtual size_t write(uint8_t); // override Print class
	virtual size_t write(const uint8_t *buffer, size_t size); // override Print class
   private:
        int _type;
        int _type_prev;
	LogFile _logFile;
};

extern DebugOutClass DebugOut;


void triggerIFTTT(String event, String value1, String value2, String value3);

String refreshFS(String tmpDir);

void HTTPGet(const char *url);

void sendWoLtoToshiyukiPC();
void sendWoL(byte *mac);

#endif

