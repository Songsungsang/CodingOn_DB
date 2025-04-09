// 통신 공부 - 클라이언트

#include <iostream>
#include <winsock2.h> // 통신을 위한 러이브러리
#include <ws2tcpip.h>
#include <vector>
#include "main.h"
using namespace std;

#pragma comment(lib, "ws2_32.lib")

int main() {
	WSADATA wsaData;
	SOCKET serverSocket, clientSocket; // 서버를 열기위한 변수
	SOCKADDR_IN serverAddr; // 소켓 주소를 담기위한 변수
	vector<char> buffer(1024);

	// Winsock 초기화
	WSAStartup(MAKEWORD(2, 2), &wsaData);


	// socket()
	clientSocket = socket(AF_INET, SOCK_STREAM, 0);

	// connect() - 연결할 서버 주소 지정
	serverAddr.sin_family = AF_INET; // IPv4
	serverAddr.sin_port = htons(12345);
	inet_pton(AF_INET, "127.0.0.1", &serverAddr.sin_addr); // 나는 어떤 서버에 접속할거야. 지금은 나와 연결하는 중
	
	connect(clientSocket, (SOCKADDR*)&serverAddr, sizeof(serverAddr)); // 연결. 두번째는 자식 요소를 부모 요소로 업케스팅 한것 임.

	cout << "Connected to server." << endl;

	//send()/recv()
	while (true) {
		cout << "Message: ";
		cin.getline(buffer.data(), sizeof(buffer));

		if (strcmp(buffer.data(), "exit") == 0) break; //strcmp - 두개 값을 비교하고 같으면 0이 나옴
	
		send(clientSocket, buffer.data(), strlen(buffer.data()), 0);

		int recvLen = recv(clientSocket, buffer.data(), sizeof(buffer), 0);
		cout << "Server receive: " << buffer.data() << endl;
	}

	// close()
	closesocket(clientSocket);
	WSACleanup();


	return 0;
}