// ��� ����

#include <iostream>
#include <winsock2.h> // ����� ���� ���̺귯��
#include <vector>
using namespace std;

#pragma comment(lib, "ws2_32.lib")

int main() {
	WSADATA wsaData;
	SOCKET serverSocket, clientSocket; // ������ �������� ����
	SOCKADDR_IN serverAddr, clientAddr; // ���� �ּҸ� ������� ����
	int clientSize = sizeof(clientAddr);
	vector<char> buffer(1024);

	// Winsock �ʱ�ȭ
	WSAStartup(MAKEWORD(2, 2), &wsaData);

	//socket() - ���� ����
	// ���� �������� ���� ����
	serverSocket = socket(AF_INET, SOCK_STREAM, 0); // ������ ����

	//bind() - ���Ͽ� �ּҸ� �����ֱ�/�־��ֱ�
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(12345); // ��Ʈ ������ ���缭 ���
	serverAddr.sin_addr.s_addr = INADDR_ANY;

	bind(serverSocket, (SOCKADDR*)&serverAddr, sizeof(serverAddr));


	//listen() - ���� ���� �غ�
	listen(serverSocket, SOMAXCONN); // ���� �ִ��� ���

	cout << "Server ready. Waiting for client..." << endl;

	// accept()
	clientSocket = accept(serverSocket, (SOCKADDR*)&clientAddr, &clientSize); // Ŭ���̾�Ʈ�� ������ �޾Ƶ��̱�

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