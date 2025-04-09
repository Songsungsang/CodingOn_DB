// 통신 공부

#include <iostream>
#include <winsock2.h> // 통신을 위한 러이브러리
#include <vector>
using namespace std;

#pragma comment(lib, "ws2_32.lib")

int main() {
	WSADATA wsaData;
	SOCKET serverSocket, clientSocket; // 서버를 열기위한 변수
	SOCKADDR_IN serverAddr, clientAddr; // 소켓 주소를 담기위한 변수
	int clientSize = sizeof(clientAddr);
	vector<char> buffer(1024);

	// Winsock 초기화
	WSAStartup(MAKEWORD(2, 2), &wsaData);

	//socket() - 서버 열기
	// 서버 소켓으로 서버 열기
	serverSocket = socket(AF_INET, SOCK_STREAM, 0); // 소켓을 생성

	//bind() - 소켓에 주소를 묶어주기/넣어주기
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(12345); // 포트 범위에 맞춰서 사용
	serverAddr.sin_addr.s_addr = INADDR_ANY;

	bind(serverSocket, (SOCKADDR*)&serverAddr, sizeof(serverAddr));


	//listen() - 서버 연결 준비
	listen(serverSocket, SOMAXCONN); // 연결 최대한 허용

	cout << "Server ready. Waiting for client..." << endl;

	// accept()
	clientSocket = accept(serverSocket, (SOCKADDR*)&clientAddr, &clientSize); // 클라이언트의 내용을 받아들이기

	cout << "Client connected!" << endl;

	//close()
	int recvLen;
	while ((recvLen = recv(clientSocket, buffer.data(), buffer.size(), 0)) > 0) {
		cout << "Received: " << string(buffer.data(), recvLen) << endl;
		send(clientSocket, buffer.data(), recvLen, 0);
	}
	
	closesocket(clientSocket);
	closesocket(serverSocket);

	return 0;
}