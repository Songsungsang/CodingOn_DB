#include <iostream>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <vector>
#include <string>

#pragma comment(lib, "ws2_32.lib")

using namespace std;

int main() {
    WSADATA wsaData;
    SOCKET clientSocket;
    SOCKADDR_IN serverAddr;
    vector<char> buffer(1024);

    // Winsock �ʱ�ȭ
    WSAStartup(MAKEWORD(2, 2), &wsaData);

    // socket()
    clientSocket = socket(AF_INET, SOCK_STREAM, 0);

    // connect()
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(12345);
    inet_pton(AF_INET, "127.0.0.1", &serverAddr.sin_addr);

    connect(clientSocket, (SOCKADDR*)&serverAddr, sizeof(serverAddr));

    cout << "Connected to server." << endl;

    // send()/recv()
    string username, password;
    cout << "���̵�: ";
    getline(std::cin, username);
    cout << "��й�ȣ: ";
    getline(std::cin, password);

    // [6] �α��� �޽��� ���� �� ����
    string message = "LOGIN:" + username + ":" + password + ":";
    send(clientSocket, message.c_str(), static_cast<int>(message.length()), 0);

    // [7] ���� ���� ���� (C++ ��Ÿ�Ϸ� ó��)
    int bytesReceived = recv(clientSocket, buffer.data(), static_cast<int>(buffer.size()), 0);

    cout << bytesReceived;

    if (bytesReceived > 0) {
        string response(buffer.data(), bytesReceived);
        cout << "[���� ����] " << response << std::endl;
    }
    else {
        cerr << "���� ���� ���� ����\n";
    }

    // [8] ����
    closesocket(clientSocket);
    WSACleanup();

    return 0;
}