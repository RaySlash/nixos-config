import os, socket 

def findActiveWorkspace():
    try:
        active = int(os.popen('hyprctl activeworkspace | grep "workspace ID" | awk {print\ \$3}').read().rstrip('\n'))
        return active
    except:
        pas

def generateYuckButton(active):
    allButtons = list()
    for i in range(1,7):
        if active == i:
            btn = f'(button :class "activeworkspace" :onclick "hyprctl dispatch workspace {i}" "{i}")'
        else:
            btn = f'(button :onclick "hyprctl dispatch workspace {i}" "{i}")'
        allButtons.append(btn)
    btns = '(box :class "workspaces" :orientation "h" :spacing 10 :space-evenly "true" ' + ' '.join(allButtons) + ')'
    return btns

if __name__ == "__main__":
    print(generateYuckButton(findActiveWorkspace()))

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock_path = f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'
    sock.connect(sock_path)

    while True:
        response = sock.recv(1024)
        if response.decode().split('>>')[0] in ['focusedmon','workspace']:
            print(generateYuckButton(findActiveWorkspace()))
        elif not response:
            sock.close()
            break

