// ��� ���� - Ŭ���̾�Ʈ

#include <iostream>
#include <winsock2.h> // ����� ���� ���̺귯��
#include <ws2tcpip.h>
#include <vector>
#include "main.h"
using namespace std;

#pragma comment(lib, "ws2_32.lib")

int main() {
	WSADATA wsaData;
	SOCKET serverSocket, clientSocket; // ������ �������� ����
	SOCKADDR_IN serverAddr; // ���� �ּҸ� ������� ����
	vector<char> buffer(1024);

	// Winsock �ʱ�ȭ
	WSAStartup(MAKEWORD(2, 2), &wsaData);


	// socket()
	clientSocket = socket(AF_INET, SOCK_STREAM, 0);

	// connect() - ������ ���� �ּ� ����
	serverAddr.sin_family = AF_INET; // IPv4
	serverAddr.sin_port = htons(12345);
	inet_pton(AF_INET, "127.0.0.1", &serverAddr.sin_addr); // ���� � ������ �����Ұž�. ������ ���� �����ϴ� ��
	
	connect(clientSocket, (SOCKADDR*)&serverAddr, sizeof(serverAddr)); // ����. �ι�°�� �ڽ� ��Ҹ� �θ� ��ҷ� ���ɽ��� �Ѱ� ��.

	cout << "Connected to server." << endl;

	//send()/recv()
	while (true) {
		cout << "Message: ";
		cin.getline(buffer.data(), sizeof(buffer));

		if (strcmp(buffer.data(), "exit") == 0) break; //strcmp - �ΰ� ���� ���ϰ� ������ 0�� ����
	
		send(clientSocket, buffer.data(), strlen(buffer.data()), 0);

		int recvLen = recv(clientSocket, buffer.data(), sizeof(buffer), 0);
		cout << "Server receive: " << buffer.data() << endl;
	}

	// close()
	closesocket(clientSocket);
	WSACleanup();


	return 0;
}