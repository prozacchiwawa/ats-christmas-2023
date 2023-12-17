import sys

material_map = {
    "Black": 0,
    "Green1": 1,
    "Red1": 2,
    "Yellow1": 3,
    "Orange": 4,
    "DarkGreen": 4+1,
    "DarkRed": 4+2,
    "DarkYellow": 4+3
}

def face(f):
    return int(f.split('/')[0])

def getcolor(c):
    cname = c.split('.')[0]
    return material_map[cname]

class ObjMesh:
    def __init__(self,lines):
        color = 0
        self.vertices = []
        self.faces = []

        for line in lines:
            if line.startswith('v '):
                words = line.split(' ')[1:]
                vtx = (float(words[0]),float(words[1]),float(words[2]))
                vtx = (100.0 * vtx[0], 100.0 * vtx[1],100.0 * vtx[2])
                self.vertices.append(vtx)
            elif line.startswith('f '):
                words = line.split(' ')[1:]
                self.faces.append((face(words[0])-1,face(words[1])-1,face(words[2])-1,color))
            elif line.startswith('usemtl '):
                color = getcolor(line.split(' ')[1])

    def add(self,vertices,faces):
        for f in self.faces:
            faces.append((f[0]+len(vertices),f[1]+len(vertices),f[2]+len(vertices),f[3]))

        for v in self.vertices:
            vertices.append(v)

def m1(f):
    if f < 0:
        return f'm1() * {int(f * -1)}'
    else:
        return f'{int(f)}'

if __name__ == '__main__':
    meshes = []
    for arg in sys.argv[1:]:
        meshes.append(ObjMesh(open(arg).read().split('\n')))

    vertices = [(0,0,0)]
    faces = []

    for m in meshes:
        m.add(vertices, faces)

    print('fn m1 (): int = (0 - 1)')
    print('')
    print(f'val nvert = {len(vertices)}')
    print(f'val ntri = {len(faces)}')
    print('')
    print('val vert =')
    print('    (arrszref)$arrpsz{struct_vertex}(')
    for (i,v) in enumerate(vertices):
        sep = ',' if i < len(vertices) - 1 else ''
        print(f'        vertex({m1(v[0])},{m1(v[1])},{m1(v[2])}){sep}')
    print('    )')
    print('')
    print('val tri =')
    print('    (arrszref)$arrpsz{struct_triangle}(')
    for (i,f) in enumerate(faces):
        sep = ',' if i < len(faces) - 1 else ''
        print(f'        tri({f[0]},{f[1]},{f[2]},{f[3]}){sep}')
    print('    )')
